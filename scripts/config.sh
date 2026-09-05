#!/usr/bin/env bash
# Entrypoint for the flake's packaged commands. Tests exercise this same script.
set -euo pipefail

command_name="${1:-help}"
shift || true
if [[ $# == 1 && $1 == --help ]]; then
  printf '%s\n' \
    'check | build [Nix flags] | switch [nh flags] | doctor | dependencies' \
    'update-core | update-tools | update-homebrew | diagram | benchmark' \
    'maintenance [--apply] [--brew] [--optimise]' \
    'Maintenance previews unless --apply is supplied; updates never activate.' \
    'Repository: NIX_CONFIG_REPO, current checkout, then NH_DARWIN_FLAKE.'
  exit 0
fi
# A checkout in the current directory wins over the installed default, so
# review workspaces cannot accidentally build or switch the main checkout.
repo="${NIX_CONFIG_REPO:-$PWD}"
if [[ -z ${NIX_CONFIG_REPO:-} && ! -f "$repo/modules/hosts.nix" ]]; then
  repo="${NH_DARWIN_FLAKE:-$repo}"
fi
host="${NIX_CONFIG_HOST:-mothekis-macbook-pro}"

fail() {
  printf '%s\n' "$*" >&2
  exit 2
}
need_repo() {
  [[ -f "$repo/flake.nix" && -f "$repo/modules/hosts.nix" ]] ||
    fail 'Run from the configuration repository, or set NIX_CONFIG_REPO to its absolute path.'
  repo="$(cd "$repo" && pwd -P)"
  cd "$repo"
  [[ $host =~ ^[A-Za-z0-9_-]+$ ]] || fail 'Invalid NIX_CONFIG_HOST.'
}
no_args() { [[ $# == 0 ]] || fail "Unexpected arguments: $*"; }
manifest() { nix eval --no-write-lock-file --json "$repo#lib.dependencyManifest"; }

case "$command_name" in
check)
  no_args "$@"
  need_repo
  # host-policy explicitly forces the complete Darwin derivation. Do not
  # evaluate it a second time in a separate process after building the checks.
  nix flake check --no-write-lock-file "$repo"
  ;;
build)
  need_repo
  exec nix build --no-write-lock-file --no-link "$repo#darwinConfigurations.$host.system" "$@"
  ;;
switch)
  need_repo
  exec nh darwin switch "$repo" --hostname "$host" --ask --no-write-lock-file "$@"
  ;;
dependencies)
  no_args "$@"
  need_repo
  manifest | jq --sort-keys .
  ;;
update-core | update-tools | update-homebrew)
  no_args "$@"
  need_repo
  temporary="$(mktemp -d)"
  trap 'rm -rf "$temporary"' EXIT
  manifest | jq --sort-keys . >"$temporary/before.json"
  case "$command_name" in
  update-core) inputs=(nixpkgs darwin home-manager den flake-parts flake-file import-tree nixvim treefmt-nix) ;;
  update-tools) inputs=(omniflake) ;;
  update-homebrew) inputs=(brew-src homebrew-core homebrew-cask fff-mcp) ;;
  esac
  nix flake update --flake "$repo" "${inputs[@]}"
  manifest | jq --sort-keys . >"$temporary/after.json"
  # diff's status 1 means a change, not failure. Other errors remain failures.
  status=0
  diff -u "$temporary/before.json" "$temporary/after.json" || status=$?
  [[ $status -le 1 ]] || exit "$status"
  printf '\nReview the lock diff with jj diff, then run check and build. Nothing was activated.\n'
  ;;
maintenance)
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
  # Read the exact same retention policy used by the evaluated launchd jobs.
  need_repo
  policy="$(nix eval --no-write-lock-file --json "$repo#lib.maintenancePolicy")"
  jq -e '.retentionArgs | type == "array" and length == 4 and .[0] == "--keep" and (.[1] | test("^[1-9][0-9]*$")) and .[2] == "--keep-since" and (.[3] | type == "string" and length > 0)' <<<"$policy" >/dev/null
  retention_lines="$(jq -er '.retentionArgs + .preserveRootsArgs | if type == "array" and length > 0 and all(.[]; type == "string") then .[] else error("Invalid retention policy") end' <<<"$policy")"
  retention=()
  while IFS= read -r arg; do retention+=("$arg"); done <<<"$retention_lines"
  system_profile="$(jq -er '.systemProfile | select(type == "string" and startswith("/nix/var/nix/profiles/"))' <<<"$policy")"
  if "$apply"; then
    nh clean user --no-gc "${retention[@]}"
    sudo "$(command -v nh)" clean profile "$system_profile" "${retention[@]}"
    if "$optimise"; then sudo "$(command -v nix)" store optimise; fi
  else
    nh clean user --dry --no-gc "${retention[@]}"
    nh clean profile "$system_profile" --dry "${retention[@]}"
    if "$optimise"; then printf 'Would optimise the Nix store.\n'; fi
  fi
  if "$brew_updates"; then
    brew_bin="${NIX_CONFIG_BREW:-/opt/homebrew/bin/brew}"
    [[ -x $brew_bin ]] || fail "Homebrew is not executable at $brew_bin"
    temporary="$(mktemp -d)"
    trap 'rm -rf "$temporary"' EXIT
    nix eval --no-write-lock-file --raw "$repo#darwinConfigurations.$host.config.homebrew.brewfile" >"$temporary/Brewfile"
    export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ANALYTICS=1
    if "$apply"; then
      # The source and taps are owned by nix-homebrew: never run brew update.
      "$brew_bin" bundle install --file="$temporary/Brewfile"
    else
      "$brew_bin" outdated
      printf 'Would upgrade/install declared Brewfile entries; no uninstall or zap.\n'
    fi
  fi
  ;;
doctor)
  no_args "$@"
  need_repo
  nix --version
  nix eval --no-write-lock-file --json "$repo#darwinConfigurations.$host.config" --apply 'c: { inherit (c) warnings; settings = { inherit (c.nix.settings) max-jobs cores auto-optimise-store; extraCaches = c.nix.settings.extra-substituters or []; }; users = builtins.mapAttrs (_: h: { inherit (h) warnings; agents = builtins.attrNames h.launchd.agents; }) c.home-manager.users; }'
  manifest | jq --sort-keys .
  nix path-info -Sh /run/current-system
  # Not being activated yet is informative, not a diagnosis of a bad build.
  for label in org.nix-community.home.nix-user-cleanup org.nixos.nix-profile-cleanup; do
    launchctl list "$label" || printf '%s is not loaded in the current launchd domain.\n' "$label"
  done
  printf 'Root job details: sudo launchctl print system/org.nixos.nix-profile-cleanup\n'
  ;;
diagram)
  no_args "$@"
  need_repo
  nix eval --no-write-lock-file --json "$repo#lib.aspectTrace" |
    python3 "${NIX_CONFIG_SCRIPTS:-$(dirname "$0")}/diagram.py"
  ;;
benchmark)
  no_args "$@"
  need_repo
  # Serial runs avoid SQLite eval-cache contention. No switches or cleanup.
  for mode in true false; do
    for run in 1 2 3; do
      printf '\neval-cache=%s run=%s\n' "$mode" "$run"
      /usr/bin/time -l nix eval --no-write-lock-file --option eval-cache "$mode" \
        --raw "$repo#darwinConfigurations.$host.system.drvPath"
      printf '\n'
    done
  done
  nix path-info -Sh /run/current-system
  ;;
*)
  fail 'Commands: check, build, switch, dependencies, update-core, update-tools, update-homebrew, maintenance, doctor, diagram, benchmark.'
  ;;
esac
