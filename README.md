# macOS Nix configuration

Declarative configuration for an Apple M1 Pro MacBook Pro (8 cores, 16 GiB RAM),
using nix-darwin, integrated Home Manager, Den and flake-parts.

**Builds, activation, dependency updates and maintenance are separate operations.**
A normal switch does not update inputs, upgrade existing Homebrew apps or uninstall
undeclared applications. Maintenance previews by default.

## Commands

Run from this repository root:

```console
nix develop                       # Reproducible repository tools
nix fmt                           # Alejandra, statix, deadnix, Markdown, shell, Python
nix run .#check                    # Build checks and fully evaluate the host
nix run .#build                    # Build the host; no activation or result symlink
nix run .#switch                   # Review the diff, confirm and activate
nix run .#doctor                   # Warnings, configured jobs, caches and revisions
nix run .#dependencies             # Direct and consumed OmniFlake revisions
nix run .#diagram                  # Mermaid from Den's actual resolution trace
nix run .#benchmark                # Serial evaluation timings; never activates
```

`NIX_CONFIG_REPO` explicitly selects a checkout. Otherwise the current repository
root wins over the installed `NH_DARWIN_FLAKE` default. This matters when using
Jujutsu workspaces. `NIX_CONFIG_HOST` selects a host; this repository defaults to
`mothekis-macbook-pro`.

`nix run .#mothekis-macbook-pro` remains available as Den's compatibility wrapper.
Prefer the explicit commands above. `build` forwards additional Nix flags, e.g.
`nix run .#build -- --dry-run`; `switch` forwards nh flags.

## Repository map

```text
flake.nix                         generated; do not hand-edit
flake.lock                        independently reviewable dependency pins
modules/
  inputs.nix                      foundational input and output declarations
  den.nix                         flake-file and Den bootstrap
  hosts.nix                       host/user inventory
  defaults.nix                    shared defaults and fixed state versions
  systems.nix                     only aarch64-darwin perSystem outputs
  formatter.nix                   reproducible formatting/static analysis
  checks.nix                      host-policy and command-safety checks
  commands.nix                    packaged operational entrypoints
  devshells.nix                   repository, mobile and systems environments
  observability.nix               dependency manifest and Den trace
  _lib/                           explicitly imported policy/loading helpers
  aspects/
    hosts/                        hardware and system feature selection
    users/                        identity, personal paths and profile selection
    profiles/                     capability composition only
    features/                     reusable Darwin/Home Manager implementation
scripts/                          tested command dispatcher and diagram renderer
tests/                            isolated command tests; no real maintenance
.github/workflows/check.yml       ARM64 macOS checks and host build; no deployment
docs/                             architecture, operations and performance notes
```

Import-tree discovers `.nix` modules under `modules/`. Files under `_lib/` are
excluded from discovery: they are ordinary Nix helpers, not flake-parts modules.
Use the same underscore convention for raw modules that need explicit imports.

## Dependency updates

```console
nix run .#update-core              # nixpkgs, Darwin, HM, Den, NixVim and tooling
nix run .#update-tools             # OmniFlake index only
nix run .#update-homebrew          # Homebrew source and taps only
jj diff                           # Review the resulting lock changes
nix run .#check
nix run .#build
nix run .#switch                   # Explicit, separate activation
```

Each updater prints the before/after consumed dependency manifest. It changes
pins, not installed software. For a narrower core update use, for example,
`nix flake update home-manager`. After changing an input declaration, regenerate
with `nix run .#write-flake`; the generated-flake check prevents drift.

Do not raise `system.stateVersion` or `home.stateVersion` during routine upgrades.

## Maintenance

```console
nix run .#maintenance                          # Preview profile pruning/GC
nix run .#maintenance -- --brew                # Also inspect Brew updates
nix run .#maintenance -- --apply               # Perform pruning and store GC
nix run .#maintenance -- --apply --brew        # Also install/upgrade declared apps
nix run .#maintenance -- --apply --optimise    # Also deduplicate store files
```

After activation, scheduled jobs retain **at least five generations and every
generation younger than fourteen days**, preserve project/direnv GC roots, and
separate user pruning, system pruning/GC and store optimization. No command runs
Homebrew `zap`. Review [the maintenance and rollback procedure](docs/operations.md)
before applying cleanup or application updates.

## Optional capabilities

Selection lives in `modules/aspects/users/motheki.nix` and the composition-only
profiles. The workstation retains the existing language-server groups through
`profiles.editor-full`; remove that include and select individual groups to slim
it further. Extra fonts and redundant editor integrations are opt-in.

```console
nix develop .#mobile              # JDK 17 + Gradle 9, outside the global profile
nix develop .#systems             # Rust/Cargo, Go and Zig toolchains
```

Nix/direnv owns project activation. Mise is available explicitly or through
`use mise` in a project's `.envrc`; it no longer installs a second activation hook.
Mutable `~/.bun/bin` and `~/.cargo/bin` no longer override declarative runtimes.

- [Architecture and capability selection](docs/architecture.md)
- [Bootstrap, updates, maintenance and rollback](docs/operations.md)
- [Performance evidence and measurement](docs/performance.md)

Secrets, signing keys, application databases, SDK downloads and machine-specific
credentials remain outside the repository and Nix store.
