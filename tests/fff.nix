# Real activation helper, isolated homes, native generated client fragments.
{
  lib,
  pkgs,
  config,
  fx,
  codex,
}: let
  merger = import ../modules/_lib/client-profiles.nix {inherit lib pkgs config;};
  # Inject a client save at the actual filesystem boundary, without test hooks
  # in production code, background processes or timing-dependent sleeps.
  raceLink = pkgs.writeShellApplication {
    name = "ln";
    text = ''
      if [[ ''${PROFILE_RACE_MODE:-} == publish && $# == 3 && $1 == -T && $3 == "$PROFILE_RACE_HOME/.fx/mcp.json" ]]; then
        printf '{"raced":true}\n' > "$3"
      fi
      exec ${pkgs.coreutils}/bin/ln "$@"
    '';
  };
  raceMove = pkgs.writeShellApplication {
    name = "mv";
    text = ''
      if [[ ''${PROFILE_RACE_MODE:-} == capture && $# == 3 && $1 == -fT && $2 == "$PROFILE_RACE_HOME/.fx/mcp.json" ]]; then
        printf '{"raced":true}\n' > "$2"
      fi
      exec ${pkgs.coreutils}/bin/mv "$@"
    '';
  };
  raceTools = pkgs.runCommand "profile-race-coreutils" {} ''
    mkdir -p "$out/bin"
    for tool in ${pkgs.coreutils}/bin/*; do ln -s "$tool" "$out/bin/"; done
    ln -sfn ${lib.getExe raceLink} "$out/bin/ln"
    ln -sfn ${lib.getExe raceMove} "$out/bin/mv"
  '';
  raceMerger = import ../modules/_lib/client-profiles.nix {
    inherit lib config;
    pkgs = pkgs // {coreutils = raceTools;};
  };
  oldFiles = pkgs.linkFarm "home-manager-files" [
    {
      name = ".config/opencode/opencode.json";
      path = pkgs.writeText "old-opencode.json" (builtins.toJSON {
        model = "keep/model";
        permission = "deny";
        mcp.other = {
          type = "local";
          command = ["keep-server"];
        };
      });
    }
    {
      name = ".config/opencode/tui.json";
      path = pkgs.writeText "old-tui.json" ''{"theme":"old","keybinds":{"leader":"ctrl+x"}}'';
    }
  ];
in
  pkgs.runCommand "fff-profile-tests" {
    nativeBuildInputs = [merger.application pkgs.jq pkgs.yq-go pkgs.coreutils];
  } ''
    set -euo pipefail
    shopt -s globstar nullglob dotglob
    home="$TMPDIR/client-home"
    mkdir "$home"
    merge-agent-profiles --check "$home"
    test ! -e "$home/.fx"
    test ! -e "$home/.codex"
    test ! -e "$home/.config"
    mkdir -p "$home/.fx" "$home/.codex" "$home/.config/opencode"
    printf '%s\n' '{"mcpServers":{"other":{"command":["keep-server"]},"fff":{"url":"obsolete"}},"custom":true}' > "$home/.fx/mcp.json"
    printf '%s\n' '{"model":"keep-me","workspaces":{"/repo":{"permission":{"*":"deny"}}},"permission":{"mcp_fff_grep":"deny","*":"ask","edit":"deny"}}' > "$home/.fx/settings.json"
    cat > "$home/.codex/config.toml" <<'TOML'
    # Original formatting and comments remain in the private backup.
    model = "keep-me"
    [projects."/repo"]
    trust_level = "trusted"
    [mcp_servers.other]
    command = "keep-server"
    [mcp_servers.fff]
    url = "https://obsolete.invalid"
    TOML
    cp "$home/.codex/config.toml" original.toml
    printf 'Personal instructions without final newline.' > "$home/.codex/AGENTS.md"
    ln -s ${oldFiles}/.config/opencode/opencode.json "$home/.config/opencode/opencode.json"
    ln -s ${oldFiles}/.config/opencode/tui.json "$home/.config/opencode/tui.json"
    cat > "$home/.config/opencode/opencode.jsonc" <<'JSONC'
    {
      // This higher-precedence profile must not shadow the managed tools.
      "model": "keep/jsonc-model",
      "permission": {"fff_grep":"deny", "*":"ask",},
    }
    JSONC
    cp "$home/.config/opencode/opencode.jsonc" original.jsonc
    merge-agent-profiles --check "$home"
    test -L "$home/.config/opencode/opencode.json"
    cmp "$home/.codex/config.toml" original.toml
    merge-agent-profiles --apply "$home"
    ${lib.concatMapStringsSep "\n" (profile: ''
        test -f "$home/${profile.path}"
        test ! -L "$home/${profile.path}"
        test "$(stat -c %a "$home/${profile.path}")" = 600
      '')
      merger.profiles}
    jq -e '.custom and .mcp.other.command == ["keep-server"] and .mcp.fff.required and .mcp.fff.enabled and (.mcp.fff | has("url") | not) and (has("mcpServers") | not)' "$home/.fx/mcp.json"
    jq -e '.model == "keep-me" and .workspaces["/repo"].permission["*"] == "deny" and .permission.edit == "deny" and .permission["*"] == "ask" and .permission.mcp_fff_grep == "allow"' "$home/.fx/settings.json"
    jq -e '.permission | keys_unsorted[-3:] == ["mcp_fff_find_files","mcp_fff_grep","mcp_fff_multi_grep"]' "$home/.fx/settings.json"
    yq -p toml -o json '.' "$home/.codex/config.toml" | jq -e '.model == "keep-me" and .projects["/repo"].trust_level == "trusted" and .mcp_servers.other.command == "keep-server" and .mcp_servers.fff.enabled and (.mcp_servers.fff | has("url") | not)'
    jq -e '.model == "keep/model" and .permission["*"] == "deny" and .permission.fff_grep == "allow" and .mcp.other.command == ["keep-server"]' "$home/.config/opencode/opencode.json"
    jq -e '.model == "keep/jsonc-model" and .permission["*"] == "ask" and .permission.fff_grep == "allow" and (.permission | keys_unsorted[-3:]) == ["fff_find_files","fff_grep","fff_multi_grep"]' "$home/.config/opencode/opencode.jsonc"
    jq -e '.theme == "system" and .keybinds.leader == "ctrl+x"' "$home/.config/opencode/tui.json"
    jq -Rse 'startswith("Personal instructions without final newline.\n\n<!-- nix:fff:start -->") and (split("<!-- nix:fff:start -->") | length == 2)' "$home/.codex/AGENTS.md"
    cmp original.toml "$home"/.codex/.config.toml.before-nix.*
    cmp original.jsonc "$home"/.config/opencode/.opencode.jsonc.before-nix.*
    cmp ${oldFiles}/.config/opencode/opencode.json "$home"/.config/opencode/.opencode.json.before-nix.*
    backups=("$home"/**/.*.before-nix.*)
    test "''${#backups[@]}" = 7
    for backup in "''${backups[@]}"; do test "$(stat -c %a "$backup")" = 600; done
    # Actual clients read these regular files, not just our model of their schema.
    HOME="$home" ${lib.getExe fx} permissions --json |
      jq -e '.rules | any(.[]; .permission == "mcp_fff_grep" and .action == "allow")'
    HOME="$home" CODEX_HOME="$home/.codex" ${lib.getExe codex} mcp get fff --json |
      jq -e '.enabled and .enabled_tools == ["find_files","grep","multi_grep"] and .transport.command == "/opt/homebrew/bin/fff-mcp"'
    # A no-op activation preserves inode/mtime and does not accumulate backups.
    stat -c '%i %Y' "$home/.codex/config.toml" > before.stat
    merge-agent-profiles --apply "$home"
    stat -c '%i %Y' "$home/.codex/config.toml" > after.stat
    cmp before.stat after.stat
    after=("$home"/**/.*.before-nix.*)
    test "''${#after[@]}" = "''${#backups[@]}"
    # Personal edits around the block survive subsequent switches.
    printf '\nPersonal trailing instructions.\n' >> "$home/.codex/AGENTS.md"
    cp "$home/.codex/AGENTS.md" expected.md
    merge-agent-profiles --apply "$home"
    cmp expected.md "$home/.codex/AGENTS.md"
    # Check/apply validate the whole batch before writing any profile.
    printf '%s\n' '{"model":"pending-merge"}' > "$home/.fx/settings.json"
    cp "$home/.fx/settings.json" pending.json
    printf '<!-- nix:fff:start -->\nUnclosed block\n' > "$home/.config/opencode/AGENTS.md"
    for mode in --check --apply; do
      if merge-agent-profiles "$mode" "$home"; then exit 1; fi
      cmp pending.json "$home/.fx/settings.json"
    done
    printf 'Personal OpenCode instructions.\n' > "$home/.config/opencode/AGENTS.md"
    for invalid in "" '{} {}' 'not-json' '[]' '{"permission":false}' '{"permission":"deny"}'; do
      printf '%s\n' "$invalid" > "$home/.fx/settings.json"
      cp "$home/.fx/settings.json" invalid.json
      if merge-agent-profiles --apply "$home"; then exit 1; fi
      cmp invalid.json "$home/.fx/settings.json"
    done
    printf '{}\n' > "$home/.fx/settings.json"
    printf 'model = [invalid TOML\n' > "$home/.codex/config.toml"
    cp "$home/.codex/config.toml" invalid.toml
    if merge-agent-profiles --apply "$home"; then exit 1; fi
    cmp invalid.toml "$home/.codex/config.toml"
    cp original.toml "$home/.codex/config.toml"
    printf '{"private-secret": BROKEN\n' > "$home/.config/opencode/opencode.jsonc"
    cp "$home/.config/opencode/opencode.jsonc" invalid.jsonc
    if merge-agent-profiles --apply "$home" 2> rejection.txt; then exit 1; fi
    cmp invalid.jsonc "$home/.config/opencode/opencode.jsonc"
    jq -Rse 'contains("private-secret") | not' rejection.txt
    # Never take ownership of foreign symlinks, including ancestor symlinks.
    unsafe="$TMPDIR/unsafe-home"
    mkdir -p "$unsafe/.fx" "$TMPDIR/outside"
    printf '{}\n' > "$TMPDIR/outside/mcp.json"
    ln -s "$TMPDIR/outside/mcp.json" "$unsafe/.fx/mcp.json"
    if merge-agent-profiles --apply "$unsafe"; then exit 1; fi
    test -L "$unsafe/.fx/mcp.json"
    rm "$unsafe/.fx/mcp.json"
    rmdir "$unsafe/.fx"
    ln -s "$TMPDIR/outside" "$unsafe/.fx"
    if merge-agent-profiles --apply "$unsafe"; then exit 1; fi
    test ! -e "$TMPDIR/outside/settings.json"
    # A save after validation is preserved, whether replacing or creating a file.
    for race in capture publish fresh; do
      raced="$TMPDIR/race-$race"
      mkdir -p "$raced/.fx"
      if [[ $race != fresh ]]; then printf '{"original":true}\n' > "$raced/.fx/mcp.json"; fi
      mode=$race
      if [[ $race == fresh ]]; then mode=publish; fi
      if PROFILE_RACE_MODE="$mode" PROFILE_RACE_HOME="$raced" ${lib.getExe raceMerger.application} --apply "$raced"; then exit 1; fi
      jq -e '.raced' "$raced/.fx/mcp.json"
      backups=("$raced"/.fx/.mcp.json.before-nix.*)
      if [[ $race == fresh ]]; then
        test "''${#backups[@]}" = 0
      elif [[ $race == capture ]]; then
        jq -e '.raced' "''${backups[0]}"
      else
        jq -e '.original' "''${backups[0]}"
      fi
    done
    # Blank homes work too; fresh contexts are not duplicated on later switches.
    fresh="$TMPDIR/fresh-home"
    mkdir "$fresh"
    merge-agent-profiles --apply "$fresh"
    merge-agent-profiles --apply "$fresh"
    backups=("$fresh"/**/.*.before-nix.*)
    test "''${#backups[@]}" = 0
    echo 'PASS: native client parsing, preservation, HM-link migration, JSONC precedence, private backups, idempotence, preflight and unsafe-input rejection' > "$out"
  ''
