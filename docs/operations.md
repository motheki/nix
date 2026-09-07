# Operations

## Bootstrap or recover this Mac

1. Back up user data and signing keys independently of Nix. Install the supported
   macOS/Xcode Command Line Tools and a current multi-user Nix installation from
   [the official installation documentation](https://nixos.org/download/).
   Enable `nix-command` and `flakes` if the installer has not done so.
1. Place the checkout at `~/Repos/personal/nix`, or set `NIX_CONFIG_REPO` to its
   absolute path. Inspect `modules/hosts.nix`, the host aspect, user identity and
   state versions before using this configuration on a different installation.
1. Use `jj status` and `jj diff` to review local changes. This is a colocated
   Jujutsu repository; do not use Git staging/commit/stash operations locally.
1. Run `nix run .#check`, then `nix run .#build`. On the first build before the new
   daemon settings are active, use `nix run .#build -- --max-jobs 2 --cores 4`.
1. Run `nix run .#switch` yourself and review nh's confirmation. The integrated
   activation installs missing declared Brew software, but does not upgrade
   existing entries or remove undeclared apps. Homebrew work is not transactional.
1. Grant the terminal **App Management** permission if requested for copying apps.
   Keep Home Manager's checks enabled. Prefer a local graphical session instead
   of granting broad remote Full Disk Access just to make activation succeed.
1. Install/authorize Xcode, SDK components, simulators, signing certificates and
   credentials with their vendor tools. These are not made reproducible by Nix.
1. Run `nix run .#doctor`. After activation, inspect the user job with
   `launchctl print gui/$(id -u)/org.nix-community.home.nix-user-cleanup` and the
   system job with `sudo launchctl print system/org.nixos.nix-profile-cleanup`.
   Check their log files and exit statuses after an actual scheduled run.

The test suite does not start launchd jobs or verify TCC interaction. Building a
plist is not proof of successful activation. The CI workflow only builds; it
never switches, cleans profiles, manages Homebrew or reads signing credentials.

After an intentional switch or a risky configuration change, manually verify:

- both user and system launchd jobs are loaded, then inspect their next exit status
  and logs;
- Home Manager applications were copied and remain launchable with the expected
  App Management permissions;
- any TCC prompts were granted only to the intended local application;
- the previous system generation still exists and the recorded rollback path is
  executable.

These runtime checks are release/activation procedures, not candidates for hosted
CI: automating them would require mutating the active Mac and granting privileged
or graphical access.

## Updates

Perform maintenance regularly rather than indefinitely deferring security fixes.
Weekly is a reasonable starting cadence for this development workstation.

- `update-core` advances explicit foundational inputs.
- `update-tools` advances only OmniFlake, which can change both optional consumers.
- `update-homebrew` advances Homebrew source and taps, not installed applications.

Each command prints before/after dependency provenance. Review `jj diff`, run
`check` and `build`, then activate separately. A failed update/check leaves the
candidate lock in the working copy for diagnosis; it does not silently restore
files or switch the running system. Use Jujutsu history to recover only the
intended change, preserving unrelated work.

When modifying input declarations, run `nix run .#write-flake` before validation.
The committed root file is generated. Do not manually edit it or run broad lock
updates when only one explicit input needs changing.

## Cleanup policy

`modules/_lib/maintenance.nix` is the single retention policy:

- Keep at least **five generations** and **all generations younger than 14 days**.
- Do not prune project/direnv GC roots automatically; this preserves cached shells.
- User launch agent: Sunday 22:15, `nh clean user --no-gc` with explicit argv.
- System launch daemon: Monday 03:15, `nh clean profile` for exactly
  `/nix/var/nix/profiles/system`, followed by nh's store GC.
- Store optimizer: Wednesday 04:15, independently scheduled by nix-darwin.

With integrated Home Manager and `useUserPackages`, there may be no separate
user profile to prune; nh's "No active profile directories" warning is normal in
that case. The system profile owns the installed user environment.

Schedules are local time; laptop sleep/login and launchd's scheduling behavior
can affect when work actually occurs. User pruning only runs in the user session.
The jobs use background priority. Logs are in `~/Library/Logs/nix-user-cleanup.log`
and `/var/log/nix-profile-cleanup.log`; inspect/log-rotate these if they grow.

The old Home Manager nh scheduler is disabled because the pinned module passed
its `extraArgs` string as one launchd argument. The old value also supplied `--max`
without the required value. An explicit argument-array check prevents recurrence.

`nix run .#maintenance` uses nh's dry mode and does not use sudo. `--apply` enables
real user pruning and privileged system cleanup. `--optimise` adds explicit store
optimization; no `--max` option is supplied. Invalid policies fail before cleanup.
The manual command can overlap scheduled jobs: avoid running it while a scheduled
job is active. Nix serializes store operations, but overlapping profile pruning
is unnecessary work.

Generations/GC roots retain store paths. A smaller new closure does not immediately
free disk space; old generations intentionally remain for rollback. Cleaning
roots sacrifices rebuild speed and can make offline rollback impossible. Review
large project roots separately rather than adding aggressive automated deletion.

## Homebrew maintenance

Native-prefix maintenance uses `/opt/homebrew/bin/brew`; override
`NIX_CONFIG_BREW` explicitly to inspect a different prefix. The Rosetta prefix is
preserved for compatibility, but is not implicitly upgraded by this command.

1. Update Homebrew source/tap pins, check/build and activate them first.
1. Run `nix run .#maintenance -- --brew` to preview profile cleanup and inspect
   outdated Brew packages. The outdated list can include unmanaged software.
1. Run `nix run .#maintenance -- --apply --brew` when ready. This also performs the
   documented Nix cleanup. Brew Bundle installs/upgrades only the candidate
   configuration's declared entries. It never calls `brew update`, `cleanup`,
   `uninstall` or `zap`. Greedy updates of self-updating apps are disabled.

For a reviewed removal, first remove the declaration and validate it. Then remove
that specific application with Homebrew yourself, retaining app data unless you
explicitly intend to delete it. Never substitute a broad automatic `zap` policy.

Some casks self-update or use mutable upstream downloads. The existing
`require_sha = false` policy is retained for compatibility. Pinned tap metadata is
not a promise of immutable app binaries or rollback of app databases. Updates
should be preceded by normal backups.

## Rollback

Before a risky switch, record the current store path and available generations:

```console
readlink /run/current-system
sudo nix-env --profile /nix/var/nix/profiles/system --list-generations
```

To roll back the **system profile**, use the installed nix-darwin tooling:

```console
sudo darwin-rebuild switch --rollback
```

If the candidate broke command lookup, use the recorded previous system's
`sw/bin/darwin-rebuild` instead of relying on PATH. Verify the target generation
still exists before proceeding. Consult `darwin-rebuild --help` for selecting a
specific older generation when more than one rollback is needed.

Nix rollback does not restore Homebrew application versions, deleted files,
application databases, Android SDKs, Xcode state or secrets. Restore those from
appropriate backups/vendor tooling. Never raise state versions to fix an upgrade.

## Optional Linux builds

Add `features.linux-builder` to the host's includes only when needed. Start with
the upstream cached builder image unchanged; customizing the image before a Linux
builder is available can make bootstrap impossible. Then tune VM memory/cores
while leaving room for IDEs and emulators on this 16 GiB Mac.

Only `aarch64-linux` is advertised. `x86_64-linux` needs a proven emulation setup or
an actual remote x86 builder. Configure daemon SSH access, verified host keys and
substitution explicitly for remote builders. Do not turn on a VM just because an
application happens to use containers through OrbStack.
