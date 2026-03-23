# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix Home Manager flake for macOS (aarch64-darwin), managing dotfiles and packages for user `motheki`. It uses flake-parts with import-tree for dendritic module organization, tracking nixpkgs master.

## Key Commands

```bash
# Apply configuration (remote nh)
rebuild

# Apply configuration (local nh installed)
rebuild-local

# Apply using home-manager directly (with --show-trace for debugging)
manage

# Clean old generations
clean        # remote nh
clean-local  # local nh

# Format all nix files (nixfmt + deadnix + statix via treefmt)
nix fmt

# Run all checks (formatting + pre-commit hooks)
nix flake check

# Enter dev shell (auto-installs git pre-commit hooks)
nix develop
```

Shell aliases (`rebuild`, `manage`, `clean`, etc.) are defined in `home.nix`.

## Architecture

- **`flake.nix`** — Inputs and `mkFlake` entry point. Uses `import-tree ./parts` to auto-discover flake-parts modules.
- **`parts/`** — Flake-parts modules (auto-imported by import-tree):
  - `home.nix` — `homeConfigurations.motheki` with overlays and home-manager module imports
  - `systems.nix` — Target systems (aarch64-darwin, x86_64-darwin)
  - `formatting.nix` — treefmt-nix integration (nixfmt, deadnix, statix)
  - `git-hooks.nix` — pre-commit hooks and devShell
- **`home.nix`** — Top-level home-manager config: username, stateVersion, shell aliases, session variables, standalone packages.
- **`modules/<name>/default.nix`** — Home-manager modules, one per program/concern. Auto-imported via `import-tree` in `parts/home.nix`.

## Adding New Modules

**Home-manager module** (program config): Create `modules/<name>/default.nix`. It will be auto-discovered by import-tree — no manual import list needed.

**Flake-parts module** (flake-level concern): Create `parts/<name>.nix`. It will be auto-discovered by import-tree.

Prefix files/directories with `_` to exclude them from import-tree (e.g., `modules/_helpers/`).

## Notable Details

- **brew-nix overlay** provides macOS casks not in nixpkgs (e.g., `brewCasks."raycast"`).
- **NUR overlay** provides charmbracelet packages (glow, vhs, wishlist).
- **nixvim** is loaded as a home-manager module.
- `--impure` and `--accept-flake-config` flags are used in rebuild aliases.
- Nixpkgs `allowUnfree = true` is set both in the flake overlay import and in `modules/nixpkgs/`.
