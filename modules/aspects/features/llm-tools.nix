# AI coding tools come directly from the llm-agents flake. No overlay is needed
# because these packages do not need to become part of the shared pkgs.
{inputs, ...}: {
  den.aspects.features.llm-tools.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    fff = import ../../_lib/fff.nix {inherit lib;};
    profiles = import ../../_lib/client-profiles.nix {inherit config lib pkgs;};
  in {
    imports = [../../_lib/hunk.nix];

    # Pi uses Node and Bun from the normal user profile configured by the
    # development profile, rather than a private wrapper or activation hack.
    home.packages = with packages; [
      fx
      tuicr
      hax
    ];

    # Keep HM's native generators, not its symlink ownership of mutable profiles.
    # The same files remain writable by the clients; no wrappers or second home.
    home.file = {
      ".fx/mcp.json" = {
        enable = false;
        text = builtins.toJSON {
          mcp.fff = {
            type = "stdio";
            # Use the nixpkgs-installed executable and fx's optional defaults:
            # a search-server startup failure must not block the entire agent.
            command = [fff.server.command];
          };
        };
      };
      ".fx/settings.json" = {
        enable = false;
        text = builtins.toJSON {permission = fff.fxPermissions;};
      };
      ".fx/AGENTS.md" = {
        enable = false;
        text = fff.context;
      };
      ".codex/config.toml".enable = false;
      ".codex/AGENTS.md".enable = false;
      ".pi/agent/pi-fff.json".text = builtins.toJSON {
        enableHomeDirScanning = false;
        enableFsRootScanning = false;
        followSymlinks = false;
      };
      # Adopt the existing mutable profile on the first switch; Pi settings are
      # declarative after that, while auth, sessions, trust, and caches stay mutable.
      "${config.home.homeDirectory}/.pi/agent/settings.json".force = true;
    };
    xdg.configFile = lib.genAttrs ["opencode/opencode.json" "opencode/tui.json" "opencode/AGENTS.md"] (_: {enable = false;});
    home.activation = {
      # Validate all profiles before any HM writes, including on dry runs.
      checkAgentProfiles = lib.hm.dag.entryBefore ["writeBoundary"] ''
        ${lib.getExe profiles.application} --check "$HOME"
      '';
      # Convert verified old HM links before linkGeneration removes obsolete links.
      mergeAgentProfiles = lib.hm.dag.entryBetween ["linkGeneration"] ["writeBoundary"] ''
        run ${lib.getExe profiles.application} --apply "$HOME"
      '';
    };

    programs = {
      hunk = {
        enable = true;
        package = packages.hunk;
        settings = {
          mode = "auto";
          theme = "rose-pine-moon";
          vcs = "jj";
          animations = true;
          transparent_background = true;
          line_numbers = true;
          wrap_lines = true;
          hunk_headers = true;
          menu_bar = true;
          agent_notes = true;
          copy_decorations = false;
          cursor_line = "row";
          watch = false;
          jj.watch = true;
        };
      };
      mcp = {
        enable = true;
        servers.fff = fff.server;
      };
      codex = {
        enable = true;
        package = packages.codex;
        enableMcpIntegration = true;
        inherit (fff) context;
        # HM merges servers by name, not recursively: retain the common command.
        settings.mcp_servers.fff =
          fff.server
          // {
            enabled_tools = fff.tools;
            tools = lib.genAttrs fff.tools (_: {approval_mode = "approve";});
          };
      };
      pi-coding-agent = {
        enable = true;
        package = packages.pi;
        settings = {
          lastChangelogVersion = lib.getVersion packages.pi;
          theme = "ghostty-sync-4a78f491";
          defaultProvider = "openai-codex";
          defaultModel = "gpt-6-astra";
          terminal.showTerminalProgress = true;
          showCacheMissNotices = true;
          collapseChangelog = true;
          quietStartup = true;
          enableInstallTelemetry = false;
          defaultProjectTrust = "always";
          defaultThinkingLevel = "high";
          # Herdr owns subagent orchestration, and native FFF makes the MCP
          # adapter redundant. Keep the remaining everyday extensions global.
          packages = [
            "npm:@ff-labs/pi-fff"
            "npm:@narumitw/pi-goal"
            "npm:@narumitw/pi-plan-mode"
            "npm:pi-lens"
            "npm:@ogulcancelik/pi-codex-compaction"
          ];
          enabledModels = [
            "openai-codex/gpt-6-astra"
            "openai-codex/gpt-5.6-sol"
          ];
          tuiMode = "fullscreen";
          modelThinkingLevels = {
            "openai-codex/gpt-6-astra" = "high";
            "openai-codex/gpt-5.6-sol" = "xhigh";
          };
        };
      };
      herdr = {
        enable = true;
        package = packages.herdr;
        settings = {
          theme = {
            auto_switch = false;
            name = "terminal";
          };
          onboarding = false;
        };
      };
      opencode = {
        enable = true;
        package = packages.opencode;
        enableMcpIntegration = true;
        inherit (fff) context;
        tui.theme = "system";
        settings = {
          autoupdate = false;
          autoshare = false;
          lsp = true;
          permission = fff.opencodePermissions;
        };
      };
    };
  };
}
