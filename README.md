# Nix configuration

The flake configures the macOS workstation and Home Manager. Home Manager's
`programs.devenv` module installs devenv and enables its native activation hooks
for Bash, Zsh, Fish, and Nushell.

## Developer environments

From this repository, enter the tooling environment with:

```sh
devenv shell
```

Add the Rust, Go, and Zig toolchains with:

```sh
devenv --profile systems shell
```

These commands replace the former `nix develop` and `nix develop .#systems`
shells. The reusable modules remain exported as `devenvModules.default` and
`devenvModules.systems` for other projects.

After applying the Home Manager configuration and starting a new terminal,
run `devenv allow` in each trusted project to enable automatic activation on
directory changes. Use `devenv revoke` to disable it. Existing projects need a
`devenv.nix` entry point; `.envrc` files no longer activate environments.
See the [devenv auto-activation documentation](https://devenv.sh/auto-activation/).

Launch editors from the environment, for example `devenv shell nvim .`, so their
language servers inherit the project's tools. Mise remains available for
explicit commands, with automatic activation disabled.

## Maintenance

`devenv.nix` composes the repository environment and its optional profiles.
`devenv.yaml` declares inputs, and `devenv.lock` pins them. Run `devenv update`
to update developer-environment dependencies; `nix flake update` separately
updates the workstation's `flake.lock`.

`devenv shell treefmt` and `nix fmt` use the same formatter configuration.
Run `devenv shell treefmt --fail-on-change` to check formatting and
`nix flake check --no-build` to evaluate the flake.

Edit flake inputs in `modules/inputs.nix`, then run `nix run .#write-flake`
to regenerate `flake.nix`.
