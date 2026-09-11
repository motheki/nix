# Declarative entrypoints; only interactions with the runtime remain shell code.
{lib}: let
  updates = {
    update-all = [];
    update-core = ["nixpkgs" "darwin" "home-manager" "den" "devenv" "flake-parts" "flake-file" "import-tree" "nixvim" "treefmt-nix"];
    update-tools = ["llm-agents"];
    update-homebrew = ["nix-homebrew" "brew-src" "homebrew-core" "homebrew-cask" "fff-mcp"];
  };
  readOnly = text: {
    inherit text;
    arguments = "none";
    tools = ["nix"];
  };
in
  {
    check = readOnly ''
      # devenv resolves the checkout root at evaluation time.
      cd "$repo"
      nix flake check --impure --no-write-lock-file "$repo"
    '';
    build = {
      arguments = "passthrough";
      tools = ["nix"];
      text = ''exec nix build --no-write-lock-file --no-link "$repo#darwinConfigurations.$host.system" "$@"'';
    };
    switch = {
      arguments = "passthrough";
      tools = ["nh"];
      text = ''exec nh darwin switch "$repo" --hostname "$host" --ask --no-write-lock-file "$@"'';
    };
    dependencies = (readOnly ''manifest | jq --sort-keys .'') // {tools = ["nix" "jq"];};
    diagram = readOnly ''nix eval --no-write-lock-file --raw "$repo#lib.aspectDiagram"'';
    doctor =
      (readOnly ''
        nix --version
        nix eval --no-write-lock-file --json "$repo#darwinConfigurations.$host.config" --apply 'c: { inherit (c) warnings; settings = { inherit (c.nix.settings) max-jobs cores auto-optimise-store; extraCaches = c.nix.settings.extra-substituters or []; }; users = builtins.mapAttrs (_: h: { inherit (h) warnings; agents = builtins.attrNames h.launchd.agents; }) c.home-manager.users; }'
        manifest | jq --sort-keys .
        nix path-info -Sh /run/current-system
        for label in org.nix-community.home.nix-user-cleanup org.nixos.nix-profile-cleanup; do
          launchctl list "$label" || printf '%s is not loaded in the current launchd domain.\n' "$label"
        done
        printf 'Root job details: sudo launchctl print system/org.nixos.nix-profile-cleanup\n'
      '')
      // {tools = ["nix" "jq"];};
    benchmark = readOnly ''
      # Serial runs avoid eval-cache contention; never activate or clean up.
      for mode in true false; do
        for run in 1 2 3; do
          printf '\neval-cache=%s run=%s\n' "$mode" "$run"
          /usr/bin/time -l nix eval --no-write-lock-file --option eval-cache "$mode" \
            --raw "$repo#darwinConfigurations.$host.system.drvPath"
          printf '\n'
        done
      done
      nix path-info -Sh /run/current-system
    '';
    maintenance = {
      arguments = "maintenance";
      tools = ["nix" "nh" "jq" "coreutils"];
      text = ''
        # Consult the selected checkout's policy, not the installed package's policy.
        policy="$(nix eval --no-write-lock-file --json "$repo#lib.maintenancePolicy")"
        jq -e '.retentionArgs | type == "array" and length == 4 and .[0] == "--keep" and (.[1] | test("^[1-9][0-9]*$")) and .[2] == "--keep-since" and (.[3] | type == "string" and length > 0)' <<<"$policy" >/dev/null
        # Reject line breaks before converting JSON strings to shell array entries.
        jq -e '.preserveRootsArgs == ["--no-gcroots", "--no-direnv"] and ([.retentionArgs[] | select(test("[\\r\\n]"))] | length == 0)' <<<"$policy" >/dev/null
        retention_lines="$(jq -er '.retentionArgs + .preserveRootsArgs | .[]' <<<"$policy")"
        retention=()
        while IFS= read -r arg; do retention+=("$arg"); done <<<"$retention_lines"
        system_profile="$(jq -er '.systemProfile | select(type == "string" and startswith("/nix/var/nix/profiles/") and (test("[\\r\\n]") | not))' <<<"$policy")"
        # Validate the optional executable before any apply action.
        if "$brew_updates"; then
          brew_bin="''${NIX_CONFIG_BREW:-/opt/homebrew/bin/brew}"
          [[ -x $brew_bin ]] || fail "Homebrew is not executable at $brew_bin"
        fi
        if "$apply"; then
          nh clean user --no-gc "''${retention[@]}"
          sudo "$(command -v nh)" clean profile "$system_profile" "''${retention[@]}"
          if "$optimise"; then sudo "$(command -v nix)" store optimise; fi
        else
          nh clean user --dry --no-gc "''${retention[@]}"
          nh clean profile "$system_profile" --dry "''${retention[@]}"
          if "$optimise"; then printf 'Would optimise the Nix store.\n'; fi
        fi
        if "$brew_updates"; then
          temporary="$(mktemp -d)"
          trap 'rm -rf "$temporary"' EXIT
          nix eval --no-write-lock-file --raw "$repo#darwinConfigurations.$host.config.homebrew.brewfile" >"$temporary/Brewfile"
          export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ANALYTICS=1
          if "$apply"; then
            # Source and taps belong to nix-homebrew. Never update, uninstall or zap.
            "$brew_bin" bundle install --file="$temporary/Brewfile"
          else
            "$brew_bin" outdated
            printf 'Would upgrade/install declared Brewfile entries; no uninstall or zap.\n'
          fi
        fi
      '';
    };
  }
  // lib.mapAttrs (_: inputs: {
    inherit inputs;
    arguments = "none";
    tools = ["nix" "jq" "coreutils" "diffutils"];
    text = ''
      temporary="$(mktemp -d)"
      trap 'rm -rf "$temporary"' EXIT
      manifest | jq --sort-keys . >"$temporary/before.json"
      nix flake update --flake "$repo" ${lib.escapeShellArgs inputs}
      manifest | jq --sort-keys . >"$temporary/after.json"
      status=0
      diff -u "$temporary/before.json" "$temporary/after.json" || status=$?
      [[ $status -le 1 ]] || exit "$status"
      printf '\nReview the lock diff with jj diff, then run check and build. Nothing was activated.\n'
    '';
  })
  updates
