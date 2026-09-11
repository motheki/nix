# Tests inject an isolated tool set through this factory, never a runtime bypass.
{
  lib,
  pkgs,
  hostName,
  tools ? pkgs,
  inheritPath ? true,
}: let
  specs = import ./command-specs.nix {inherit lib;};
  help = ''
    ${lib.concatStringsSep " | " (builtins.attrNames specs)}
    build [Nix flags] | switch [nh flags]
    maintenance [--apply] [--brew] [--optimise]
    Maintenance previews unless --apply is supplied; updates never activate.
    Repository: NIX_CONFIG_REPO, current checkout, then NH_DARWIN_FLAKE.
    Host: NIX_CONFIG_HOST overrides the packaged default.
  '';
  arguments = {
    none = ''[[ $# == 0 ]] || fail "Unexpected arguments: $*"'';
    passthrough = "";
    maintenance = ''
      apply=false
      brew_updates=false
      optimise=false
      for arg in "$@"; do
        case "$arg" in
          --apply) apply=true ;;
          --brew) brew_updates=true ;;
          --optimise) optimise=true ;;
          *) fail "Unknown maintenance option: $arg (use --apply, --brew, --optimise)." ;;
        esac
      done
    '';
  };
in
  lib.mapAttrs (name: spec:
    pkgs.writeShellApplication {
      inherit name inheritPath;
      runtimeInputs = map (tool: tools.${tool}) spec.tools;
      text = ''
        if [[ $# == 1 && $1 == --help ]]; then
          printf '%s' ${lib.escapeShellArg help}
          exit 0
        fi
        fail() { printf '%s\n' "$*" >&2; exit 2; }
        ${arguments.${spec.arguments}}
        # A current checkout wins over the installed NH default.
        repo="''${NIX_CONFIG_REPO:-$PWD}"
        if [[ -z ''${NIX_CONFIG_REPO:-} && ! -f "$repo/modules/hosts.nix" ]]; then
          repo="''${NH_DARWIN_FLAKE:-$repo}"
        fi
        host="''${NIX_CONFIG_HOST:-${hostName}}"
        [[ -f "$repo/flake.nix" && -f "$repo/modules/hosts.nix" ]] ||
          fail 'Run from the configuration repository, or set NIX_CONFIG_REPO to its absolute path.'
        repo="$(cd "$repo" && pwd -P)"
        cd "$repo"
        [[ $host =~ ^[A-Za-z0-9_-]+$ ]] || fail 'Invalid NIX_CONFIG_HOST.'
        manifest() { nix eval --no-write-lock-file --json "$repo#lib.dependencyManifest"; }
        ${spec.text}
      '';
    })
  specs
