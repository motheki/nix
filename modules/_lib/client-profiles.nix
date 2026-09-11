# Keep native HM config generation, but merge runtime-owned profiles instead of
# linking over them. Only declarative fragments enter the store, never user data.
{
  lib,
  pkgs,
  config,
}: let
  home = path: format: kind: {
    inherit path format kind;
    source = config.home.file.${path}.source;
  };
  xdg = name: format: {
    path = lib.removePrefix "${config.home.homeDirectory}/" "${config.xdg.configHome}/${name}";
    source = config.xdg.configFile.${name}.source;
    kind = "opencode";
    inherit format;
  };
  profiles = [
    (home ".fx/mcp.json" "json" "fx-mcp")
    (home ".fx/settings.json" "json" "fx-settings")
    (home ".fx/AGENTS.md" "markdown" "context")
    (home ".codex/config.toml" "toml" "codex")
    (home ".codex/AGENTS.md" "markdown" "context")
    (xdg "opencode/opencode.json" "jsonc")
    (xdg "opencode/tui.json" "jsonc")
    (xdg "opencode/AGENTS.md" "markdown")
  ];
  manifest = pkgs.writeText "agent-profile-fragments.json" (builtins.toJSON profiles);
  mergeJson = pkgs.writeText "merge-agent-profile.jq" ''
    def object: if type == "object" then . else error("Expected an object") end;
    def optionalObject: if . == null then {} else object end;
    if length != 1 then error("Expected exactly one profile") else .[0] | object end |
    if $kind == "fx-mcp" then
      if has("MCP-Servers") then error("Unsupported MCP alias") else . end |
      .mcp = ((.mcpServers | optionalObject) + (.mcp | optionalObject)) | del(.mcpServers)
    else . end |
    if $kind == "opencode" and (.permission | type) == "string" then
      if .permission == "allow" or .permission == "ask" or .permission == "deny"
      then .permission = {"*": .permission} else error("Invalid permission") end
    else . end |
    . as $old | $patch[0] as $new |
    ($old * $new) |
    # A declared server is a whole identity: remove obsolete URL/cwd/env fields,
    # but leave every other server untouched. Specific permissions go last.
    reduce ["mcp", "mcp_servers", "permission"][] as $key (. ;
      if $new | has($key) then
        .[$key] = (
          reduce ($new[$key] | keys[]) as $owned
            ($old[$key] | optionalObject; del(.[$owned]))
          + $new[$key]
        )
      else . end)
  '';
  mergeContext = pkgs.writeText "merge-agent-context.jq" ''
    "<!-- nix:fff:start -->" as $begin | "<!-- nix:fff:end -->" as $end |
    ($begin + "\n" + $patch + $end) as $block |
    if . == "" or . == $patch then $block + "\n" else
      (split($begin)) as $starts | (split($end)) as $ends |
      if ($starts | length) == 1 and ($ends | length) == 1 then
        . + (if endswith("\n") then "\n" else "\n\n" end) + $block + "\n"
      elif ($starts | length) == 2 and ($ends | length) == 2
        and (($starts[1] | split($end) | length) == 2) then
        $starts[0] + $block + $ends[1]
      else error("Ambiguous managed instruction markers") end
    end
  '';
  application = pkgs.writeShellApplication {
    name = "merge-agent-profiles";
    runtimeInputs = [pkgs.jq pkgs.coreutils pkgs.yq-go pkgs.python3Packages.json5];
    text = ''
      [[ $# == 2 && ( $1 == --check || $1 == --apply ) ]] || {
        echo 'Usage: merge-agent-profiles --check|--apply HOME' >&2; exit 2;
      }
      mode=$1
      root=$(realpath -e "$2")
      [[ -d $root && -O $root ]] || { echo 'Expected a user-owned home directory' >&2; exit 1; }
      umask 077
      work=$(mktemp -d)
      temporary=""
      trap 'rm -rf "$work"; if [[ -n $temporary ]]; then rm -f "$temporary"; fi' EXIT
      fail() { echo "Agent profile: $*; no unsafe overwrite attempted." >&2; exit 1; }
      safe_path() {
        local relative=$1 parent link resolved
        [[ $relative != /* && /$relative/ != *'/../'* && /$relative/ != *'/./'* ]] || fail 'invalid relative path'
        parent=$(dirname "$root/$relative")
        while [[ $parent != "$root" ]]; do
          [[ ! -L $parent && ( ! -e $parent || ( -d $parent && -O $parent ) ) ]] || fail "unsafe directory for $relative"
          parent=$(dirname "$parent")
        done
        if [[ -L $root/$relative ]]; then
          link=$(readlink "$root/$relative")
          resolved=$(realpath -e "$root/$relative") || fail "broken link at $relative"
          [[ $link == ${builtins.storeDir}/*-home-manager-files/"$relative" && $resolved == ${builtins.storeDir}/* && -f $resolved ]] || fail "unmanaged symlink at $relative"
          [[ $(stat -c %u "$root/$relative") == "$(id -u)" ]] || fail "foreign link at $relative"
        else
          [[ ! -e $root/$relative || ( -f $root/$relative && -O $root/$relative ) ]] || fail "unsafe file at $relative"
        fi
      }
      # OpenCode loads JSONC after JSON. Update existing companions too, rather
      # than leaving a higher-precedence stale config that silently hides FFF.
      jq -c '.[]' ${manifest} > "$work/profiles"
      while IFS= read -r profile; do
        relative=$(jq -r .path <<< "$profile")
        if [[ $(jq -r .format <<< "$profile") == jsonc && ( -e $root/''${relative}c || -L $root/''${relative}c ) ]]; then
          jq -c '.path += "c"' <<< "$profile" >> "$work/profiles"
        fi
      done < <(jq -c '.[]' ${manifest})
      index=0
      while IFS= read -r profile; do
        relative=$(jq -r .path <<< "$profile")
        source=$(jq -r .source <<< "$profile")
        format=$(jq -r .format <<< "$profile")
        kind=$(jq -r .kind <<< "$profile")
        safe_path "$relative"
        target=$root/$relative
        mkdir "$work/$index"
        if [[ -e $target ]]; then
          cp -L "$target" "$work/$index/original"
          if [[ -L $target ]]; then readlink "$target" > "$work/$index/link"; fi
        else
          touch "$work/$index/absent" "$work/$index/original"
        fi
        original=$work/$index/original
        result=$work/$index/result
        if [[ $format == markdown ]]; then
          jq -e -j -R -s --rawfile patch "$source" -f ${mergeContext} "$original" > "$result" 2> "$work/error" || fail "invalid instruction markers in $relative"
        else
          if [[ $format == toml ]]; then
            yq -p toml -o json '.' "$source" > "$work/patch.json" 2> "$work/error" || fail 'invalid declarative TOML'
          else
            cat "$source" > "$work/patch.json"
          fi
          if [[ -e $work/$index/absent ]]; then
            echo '{}' > "$work/input.json"
          elif [[ $format == toml ]]; then
            yq -p toml -o json '. // {}' "$original" > "$work/input.json" 2> "$work/error" || fail "invalid TOML in $relative"
          elif [[ $format == jsonc ]]; then
            pyjson5 --as-json "$original" > "$work/input.json" 2> "$work/error" || fail "invalid JSONC in $relative"
          else
            cp "$original" "$work/input.json"
          fi
          jq -e -s --arg kind "$kind" --slurpfile patch "$work/patch.json" -f ${mergeJson} "$work/input.json" > "$work/merged.json" 2> "$work/error" || fail "invalid configuration in $relative"
          if [[ $format == toml ]]; then
            yq -p json -o toml '.' "$work/merged.json" > "$result" 2> "$work/error" || fail "cannot encode TOML for $relative"
          else
            cp "$work/merged.json" "$result"
          fi
        fi
        index=$((index + 1))
      done < "$work/profiles"
      if [[ $mode == --check ]]; then
        echo 'Agent profiles: all fragments and existing profiles validated (no profile writes).'
        exit 0
      fi
      # Recheck the complete batch before committing any file. Never clobber an
      # edit made by a client while validation was running.
      index=0
      while IFS= read -r profile; do
        relative=$(jq -r .path <<< "$profile")
        safe_path "$relative"
        target=$root/$relative
        if [[ -e $work/$index/absent ]]; then
          [[ ! -e $target && ! -L $target ]] || fail "$relative changed during validation"
        else
          cmp -s "$target" "$work/$index/original" || fail "$relative changed during validation"
          if [[ -e $work/$index/link ]]; then
            [[ -L $target && $(readlink "$target") == "$(cat "$work/$index/link")" ]] || fail "$relative link changed"
          else
            [[ ! -L $target ]] || fail "$relative became a symlink"
          fi
        fi
        index=$((index + 1))
      done < "$work/profiles"
      index=0
      while IFS= read -r profile; do
        relative=$(jq -r .path <<< "$profile")
        target=$root/$relative
        result=$work/$index/result
        if [[ ! -L $target && -f $target ]] && cmp -s "$target" "$result" && [[ $(stat -c %a "$target") == 600 ]]; then
          index=$((index + 1)); continue
        fi
        directory=$(dirname "$target")
        mkdir -p "$directory"
        temporary=$(mktemp "$directory/.agent-profile.XXXXXX")
        cat "$result" > "$temporary"
        backup=""
        if [[ ! -e $work/$index/absent ]]; then
          backup=$(mktemp "$directory/.$(basename "$target").before-nix.XXXXXX")
          # Capture the current inode, not the earlier snapshot. A racing save
          # must survive either at its original path or in this private backup.
          mv -fT "$target" "$backup"
          matches=true
          if [[ -e $work/$index/link ]]; then
            [[ -L $backup && $(readlink "$backup") == "$(cat "$work/$index/link")" ]] || matches=false
          else
            [[ ! -L $backup ]] || matches=false
          fi
          if [[ $matches != true ]] || ! cmp -s "$backup" "$work/$index/original"; then
            ln -PT "$backup" "$target" 2>/dev/null || true
            fail "$relative changed; retained at $backup"
          fi
          # Make a store-independent regular backup of an old immutable HM link.
          if [[ -L $backup ]]; then cp --remove-destination "$work/$index/original" "$backup"; fi
          chmod 600 "$backup"
          echo "Agent profile backup: $backup"
        fi
        # Publish a complete file only if the path is still absent. Unlike mv -f,
        # link creation cannot destroy a client's intervening atomic save.
        if ! ln -T "$temporary" "$target" 2>/dev/null; then
          if [[ -n $backup ]]; then ln -PT "$backup" "$target" 2>/dev/null || true; fi
          fail "cannot install $relative without overwrite; original backup: $backup"
        fi
        rm "$temporary"
        temporary=""
        index=$((index + 1))
      done < "$work/profiles"
      echo 'Agent profiles: declared settings merged; other preferences and instructions preserved.'
    '';
  };
in {
  inherit profiles application;
}
