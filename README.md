# Nix configuration

`flake.nix` is the source of truth for inputs, the macOS workstation and Home
Manager configuration, formatting, and developer shells. Flake-parts composes
these with the existing Den aspects in `modules/`; `flake.lock` pins all inputs.
There is no generated flake or separate devenv configuration or lockfile.

## Developer environments

Enter the repository tooling environment:

```sh
nix develop --no-pure-eval
```

Add the Rust, Go, and Zig toolchains (including language servers and the macOS
SDK):

```sh
nix develop --no-pure-eval .#systems
```

Both shells include nixd, Alejandra, Statix, deadnix, jq, nh, hyperfine, and the
same treefmt wrapper used by `nix fmt`. The default shell does not add a compiler
or SDK. Neither shell formats files automatically on entry.

The shells are defined directly in `perSystem.devenv.shells`, sharing one tooling
package list. This is the
[devenv flake-parts integration](https://devenv.sh/guides/using-with-flake-parts/),
not the separate [numtide devshell integration](https://flake.parts/options/devshell.html).
`--no-pure-eval` lets devenv discover the working directory without hard-coding
an absolute path or generating a root file.

### Automatic activation

Home Manager enables direnv and nix-direnv for Bash, Zsh, Fish, and Nushell.
After applying the workstation configuration and starting a new terminal:

```sh
direnv allow
```

The repository's `.envrc` only loads the default flake shell. Launch editors
from this environment, or explicitly with:

```sh
nix develop --no-pure-eval -c nvim .
```

The devenv CLI remains available for other projects, but its native activation
hooks are disabled so direnv is the only directory-change hook. Existing
standalone devenv projects need an `.envrc` with `use devenv` and `direnv allow`;
`devenv allow` no longer controls activation. Mise remains available for explicit
commands, with automatic activation disabled.

The former `devenv shell` and `devenv --profile systems shell` commands are
replaced by the two `nix develop` commands above. The standalone `devenvModules`
exports have been removed; consumers can use this flake's `devShells` outputs.

## Maintenance

Edit inputs directly in `flake.nix`, then update the single lockfile with
`nix flake update` (or `nix flake update <input>` for a targeted update).
No regeneration command or `devenv update` is needed.

The Home Manager-managed `rebuild` command works from any directory. It changes
to this repository, runs `nix flake update`, then runs
`nh darwin switch . -H mothekis-macbook-pro --ask` to build and activate the
workstation, including Home Manager. An update failure stops the command before
activation; `--ask` prompts before applying the built configuration.
The former `rebuild-update` alias has been removed.

```sh
nix fmt
nix develop --no-pure-eval -c treefmt --fail-on-change
nix flake check --no-pure-eval --no-build
```

The last command evaluates the workstation, shell, package, and check outputs
without building them. Use `nix flake check --no-pure-eval` to build and run the
checks as well.
