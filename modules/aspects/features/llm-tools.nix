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
    # Pi uses Node and Bun from the normal user profile configured by the
    # development profile, rather than a private wrapper or activation hack.
    home.packages = with packages; [
      fx
      tuicr
    ];

    # Keep HM's native generators, not its symlink ownership of mutable profiles.
    # The same files remain writable by the clients; no wrappers or second home.
    home.file = {
      ".fx/mcp.json" = {
        enable = false;
        text = builtins.toJSON {
          mcp.fff = {
            type = "stdio";
            command = [fff.server.command] ++ fff.server.args;
            enabled = true;
            required = true;
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
