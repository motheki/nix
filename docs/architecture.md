# Architecture

This is a dendritic flake-parts configuration:

- `flake-file` owns the generated root `flake.nix`.
- `import-tree` imports the Nix modules below `modules/`.
- Den composes host, user, profile, and feature aspects.
- nix-darwin owns macOS system configuration.
- Home Manager owns user programs and shell configuration.
- devenv supplies the development shells.
- nix-direnv caches and activates the default shell.
- nh builds and switches the Den-generated host output.

`modules/den.nix` uses the supported `flakeModules.dendritic` integrations from
flake-file and Den. `modules/commands.nix` only exposes flake-file's writer and
Den's native nh host/home packages; it contains no custom command dispatcher.

The declared host is `mothekis-macbook-pro` on `aarch64-darwin`, with the
integrated Home Manager user `motheki`. Hosts hold hardware and system policy,
users hold identity and selected profiles, profiles contain only feature
composition, and features contain implementations.

The generated file must not be edited by hand. After changing input declarations,
run `nix run .#write-flake`.

References:

- [Den default template](https://den.denful.dev/tutorials/default/)
- [flake-file](https://flake-file.denful.dev/)
- [Home Manager options](https://nix-community.github.io/home-manager/options.html)
- [nix-darwin options](https://nix-darwin.github.io/nix-darwin/manual/)
- [flake-parts](https://flake.parts/)
- [devenv with flake-parts](https://devenv.sh/guides/using-with-flake-parts/)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- [nh](https://github.com/nix-community/nh)
