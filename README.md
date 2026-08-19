# macOS Nix configuration

This repository declares one Apple Silicon Mac and its Home Manager user with
[Den](https://den.denful.dev/). Den composes the named aspects into standard
`darwinConfigurations`, while flake-parts owns per-system outputs and
import-tree discovers every Nix module below `modules/`.

## Repository map

```text
flake.nix                          generated input/output entry point
flake.lock                         pinned dependency graph
modules/
  dendritic.nix                    bootstraps flake-file and Den
  inputs.nix                       source of truth for flake inputs
  systems.nix                      platforms for perSystem outputs
  hosts.nix                        host and user inventory
  defaults.nix                     state versions and shared Den batteries
  formatter.nix                    nixfmt, deadnix, and statix via treefmt
  nh.nix                           nh-backed build/switch package per host
  aspects/
    hosts/                         machine-specific nix-darwin configuration
    users/                         user identity and profile composition
    profiles/                      reusable Home Manager concerns
```

`import-tree` imports every `.nix` file below `modules/`. Add compatible
flake-parts/Den modules directly to that tree. Put helper or raw module files
under a path beginning with `_` so import-tree ignores them, then import those
files explicitly from the appropriate Darwin or Home Manager class.

## Common commands

```console
# Format Nix and run the configured static rewrites.
nix fmt

# Evaluate checks without building activation packages.
nix flake check --no-build

# Fully evaluate the host activation derivation.
nix eval .#darwinConfigurations.mothekis-macbook-pro.system.drvPath

# Build or switch through Den's generated nh wrapper.
nix run .#mothekis-macbook-pro
nix run .#mothekis-macbook-pro -- switch
```

After changing `modules/inputs.nix`, regenerate the root flake and update only
inputs whose revisions you intentionally want to review:

```console
nix run .#write-flake
nix flake update <input-name>
```

Do not raise `system.stateVersion` or `home.stateVersion` as part of a routine
upgrade; they are compatibility markers for the original installation.

## Configuration boundaries

- **Nix packages** use Home Manager `programs.*` modules where available and
  `home.packages` otherwise. External flake packages are selected directly;
  overlays are intentionally absent because no package override is required.
- **Homebrew** is limited to macOS software not managed well through Nix.
  `nix-homebrew` pins Homebrew and taps; nix-darwin manages the Brewfile.
- **Shells** are configured by Home Manager. Den's `user-shell` battery owns the
  login shell and account-level wiring.
- **Secrets and mutable application state** do not belong in this repository.
