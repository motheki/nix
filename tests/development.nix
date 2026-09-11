# Pure contracts for the flake-parts/devenv/nix-direnv integration.
{
  lib,
  pkgs,
  config,
}: let
  shell = config.devenv.shells.default;
  envrc = builtins.readFile ../.envrc;
  tests = {
    testDefaultShell = {
      expr = shell.name;
      expected = "nix-config";
    };
    testShellMarker = {
      expr = shell.env.NIX_CONFIG_SHELL;
      expected = "nix-config";
    };
    testSharedFormatter = {
      expr = lib.any (p: toString p == toString config.treefmt.build.wrapper) shell.packages;
      expected = true;
    };
    testNoFormattingOnEntry = {
      expr = shell.treefmt.enable;
      expected = false;
    };
    testNoGitHookInstallation = {
      expr = lib.any (hook: hook.enable) (builtins.attrValues shell.git-hooks.hooks);
      expected = false;
    };
    testDirenvLoader = {
      expr = lib.hasInfix "use flake . --impure" envrc;
      expected = true;
    };
    testImportedFileWatching = {
      expr = lib.hasInfix "watch_file modules modules/**/ modules/**/*.nix tests tests/**/*.nix" envrc;
      expected = true;
    };
    testNoStandaloneScripts = {
      expr = builtins.pathExists ../scripts/config.sh || builtins.pathExists ../scripts/diagram.py || builtins.pathExists ../tests/test_commands.py;
      expected = false;
    };
  };
  failures = lib.runTests tests;
in
  assert lib.assertMsg (failures == []) (builtins.toJSON failures);
    pkgs.writeText "development-contracts" (builtins.toJSON {passed = builtins.attrNames tests;})
