# Operations

## Repair the macOS temporary directory

Nix cannot evaluate any flake while `/tmp` points to a missing `/private/tmp`.
Restore the standard macOS directory once:

```console
sudo mkdir -p /private/tmp
sudo chown root:wheel /private/tmp
sudo chmod 1777 /private/tmp
```

Confirm it with `ls -ld /tmp /private/tmp` before running Nix commands.

## Update, check, and switch

Run the supported tools directly instead of repository-specific wrappers:

```console
nix run .#write-flake && \
  nix flake update && \
  nix flake check --impure && \
  nix run .#mothekis-macbook-pro -- switch
```

`write-flake` regenerates the root `flake.nix` from `modules/inputs.nix`.
`nix flake update` updates `flake.lock`, and `nix flake check` runs the checks
provided by flake-file and treefmt. Den's host package delegates the final build
and activation to `nh darwin`.

Review `jj diff` before switching. To build without activating, omit `-- switch`:

```console
nix run .#mothekis-macbook-pro
```

Home Manager installs the following alias in Bash, Zsh, Fish, and Nushell:

```console
rebuild
```

It expands to the Den host wrapper's switch action. The checkout path comes from
`programs.nh.darwinFlake` and the user aspect.

## Development shell

Approve `.envrc` once with `direnv allow`. nix-direnv then caches the devenv shell.
Manual entry remains `nix develop --impure`.

## Rollback

List generations before a risky activation:

```console
sudo nix-env --profile /nix/var/nix/profiles/system --list-generations
```

Roll back with nix-darwin's installed command:

```console
sudo darwin-rebuild switch --rollback
```
