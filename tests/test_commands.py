"""Exercise command routing and safety with fake executables, never the host."""

import importlib.util
import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

SCRIPTS = Path(
    os.environ.get("CONFIG_SCRIPTS", Path(__file__).resolve().parents[1] / "scripts")
)
POLICY = {
    "retentionArgs": ["--keep", "5", "--keep-since", "14d"],
    "preserveRootsArgs": ["--no-gcroots", "--no-direnv"],
    "systemProfile": "/nix/var/nix/profiles/system",
}
FAKE = """import json, os, pathlib, subprocess, sys
name = pathlib.Path(sys.argv[0]).name
args = sys.argv[1:]
with open(os.environ["CALL_LOG"], "a") as stream:
    stream.write(json.dumps([name, *args]) + "\\n")
if name == "nix":
    if any("maintenancePolicy" in a for a in args):
        print(os.environ["POLICY"])
    elif any("dependencyManifest" in a for a in args):
        print(json.dumps({"revision": "new" if pathlib.Path(os.environ["UPDATED"]).exists() else "old"}))
    elif any("homebrew.brewfile" in a for a in args):
        print('cask "example"')
    elif args[:2] == ["flake", "update"]:
        pathlib.Path(os.environ["UPDATED"]).touch()
if name == "sudo":
    sys.exit(subprocess.call(args))
"""


class Commands(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="nix-config-tests-")
        self.addCleanup(self.temporary.cleanup)
        root = Path(self.temporary.name).resolve()
        self.repo = root / "repository with spaces"
        (self.repo / "modules").mkdir(parents=True)
        (self.repo / "flake.nix").touch()
        (self.repo / "modules/hosts.nix").touch()
        self.bin = root / "bin"
        self.bin.mkdir()
        self.log = root / "calls.jsonl"
        for name in ("nix", "nh", "sudo", "brew"):
            executable = self.bin / name
            executable.write_text(f"#!{sys.executable}\n" + FAKE)
            executable.chmod(0o755)
        self.env = dict(
            os.environ,
            PATH=f"{self.bin}:{os.environ['PATH']}",
            NIX_CONFIG_REPO=str(self.repo),
            NIX_CONFIG_HOST="test-host",
            NIX_CONFIG_BREW=str(self.bin / "brew"),
            CALL_LOG=str(self.log),
            POLICY=json.dumps(POLICY),
            UPDATED=str(root / "updated"),
        )

    def run_command(self, *args, success=True):
        bash = shutil.which("bash")
        assert bash is not None, "bash is required for command tests"
        result = subprocess.run(
            [bash, str(SCRIPTS / "config.sh"), *args],
            env=self.env,
            cwd=self.repo,
            text=True,
            capture_output=True,
            check=False,
            timeout=20,
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0)
        return result

    def calls(self, name=None):
        rows = (
            [json.loads(line) for line in self.log.read_text().splitlines()]
            if self.log.exists()
            else []
        )
        return [row for row in rows if name is None or row[0] == name]

    def test_check_builds_checks_without_redundant_evaluation(self):
        self.run_command("check")
        (call,) = self.calls("nix")
        self.assertEqual(call[1:3], ["flake", "check"])
        self.assertNotIn("--no-build", call)
        self.assertIn("--no-write-lock-file", call)

    def test_build_does_not_activate_or_update(self):
        self.run_command("build", "--dry-run")
        (call,) = self.calls()
        self.assertEqual(call[:2], ["nix", "build"])
        self.assertIn("--no-link", call)
        self.assertIn("--no-write-lock-file", call)
        self.assertIn("--dry-run", call)

    def test_current_checkout_wins_over_installed_default(self):
        self.env.pop("NIX_CONFIG_REPO")
        self.env["NH_DARWIN_FLAKE"] = "/wrong-checkout"
        self.run_command("build")
        (call,) = self.calls("nix")
        self.assertIn(f"{self.repo}#darwinConfigurations.test-host.system", call)

    def test_switch_confirms_and_keeps_lock(self):
        self.run_command("switch")
        (call,) = self.calls("nh")
        self.assertEqual(call[1:3], ["darwin", "switch"])
        self.assertIn("--ask", call)
        self.assertIn("--no-write-lock-file", call)
        self.assertNotIn("--update", call)
        self.assertIn(str(self.repo), call)

    def test_maintenance_defaults_to_preview(self):
        self.run_command("maintenance", "--optimise")
        calls = self.calls("nh")
        self.assertEqual(len(calls), 2)
        for call in calls:
            self.assertIn("--dry", call)
            for arg in POLICY["retentionArgs"] + POLICY["preserveRootsArgs"]:
                self.assertIn(arg, call)
        self.assertIn("--no-gc", calls[0])
        self.assertFalse(self.calls("sudo"))
        self.assertFalse(self.calls("brew"))

    def test_maintenance_apply_scopes_system_cleanup(self):
        self.run_command("maintenance", "--apply", "--optimise")
        user, system = self.calls("nh")
        self.assertIn("--no-gc", user)
        self.assertIn(POLICY["systemProfile"], system)
        self.assertNotIn("--dry", system)
        self.assertEqual(len(self.calls("sudo")), 2)
        self.assertEqual(self.calls("nix")[-1][1:], ["store", "optimise"])

    def test_invalid_policy_fails_before_cleanup(self):
        for value in (
            "not json",
            "{}",
            json.dumps(dict(POLICY, retentionArgs=[], preserveRootsArgs=[])),
            json.dumps(dict(POLICY, retentionArgs=[])),
            json.dumps(
                dict(POLICY, retentionArgs=["--keep", "0", "--keep-since", "14d"])
            ),
            json.dumps(dict(POLICY, systemProfile="/wrong-profile")),
        ):
            with self.subTest(value=value):
                self.env["POLICY"] = value
                self.run_command("maintenance", "--apply", success=False)
                self.assertFalse(self.calls("nh"))
                self.assertFalse(self.calls("sudo"))

    def test_brew_preview_does_not_modify_taps(self):
        self.run_command("maintenance", "--brew")
        self.assertEqual(self.calls("brew"), [["brew", "outdated"]])
        self.assertFalse(self.calls("sudo"))

    def test_brew_apply_uses_declared_bundle_without_cleanup(self):
        self.run_command("maintenance", "--brew", "--apply")
        (call,) = self.calls("brew")
        self.assertEqual(call[1:3], ["bundle", "install"])
        self.assertTrue(call[3].startswith("--file="))
        self.assertNotIn("cleanup", call)
        self.assertNotIn("update", call)
        self.assertNotIn("--zap", call)

    def test_update_groups_are_disjoint(self):
        expected = {
            "update-core": [
                "nixpkgs",
                "darwin",
                "home-manager",
                "den",
                "flake-parts",
                "flake-file",
                "import-tree",
                "nixvim",
                "treefmt-nix",
            ],
            "update-tools": ["omniflake"],
            "update-homebrew": [
                "brew-src",
                "homebrew-core",
                "homebrew-cask",
                "fff-mcp",
            ],
        }
        for command, inputs in expected.items():
            with self.subTest(command=command):
                self.log.unlink(missing_ok=True)
                self.run_command(command)
                (update,) = [
                    row for row in self.calls("nix") if row[1:3] == ["flake", "update"]
                ]
                self.assertEqual(update[5:], inputs)
                self.assertFalse(self.calls("nh"))
                self.assertFalse(self.calls("brew"))

    def test_invalid_args_and_host_fail_closed(self):
        self.run_command("maintenance", "--unknown", success=False)
        self.run_command("update-core", "omniflake", success=False)
        self.env["NIX_CONFIG_HOST"] = "bad;host"
        self.run_command("switch", success=False)
        self.assertFalse(self.calls())

    def test_help_needs_no_repository(self):
        self.env["NIX_CONFIG_REPO"] = "/nonexistent"
        result = self.run_command("maintenance", "--help")
        self.assertIn("previews unless --apply", result.stdout)
        self.assertFalse(self.calls())

    def test_missing_repo_fails_without_mutation(self):
        self.env["NIX_CONFIG_REPO"] = str(self.repo / "missing")
        self.run_command("maintenance", "--apply", success=False)
        self.assertFalse(self.calls())


class Diagram(unittest.TestCase):
    def test_deterministic_edges_and_escaping(self):
        spec = importlib.util.spec_from_file_location("diagram", SCRIPTS / "diagram.py")
        assert spec is not None and spec.loader is not None
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        entries = [
            {"name": 'child"', "parent": "root"},
            {"name": "root", "parent": "root"},
        ]
        output = module.render(entries)
        self.assertEqual(output, module.render(list(reversed(entries))))
        self.assertEqual(output.count(" --> "), 1)
        self.assertIn("&quot;", output)

    def test_invalid_input_fails(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPTS / "diagram.py")],
            input="not-json",
            capture_output=True,
            text=True,
            check=False,
            timeout=10,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Invalid Den trace", result.stderr)


if __name__ == "__main__":
    unittest.main()
