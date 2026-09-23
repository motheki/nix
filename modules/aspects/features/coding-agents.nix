# Native modules manage configuration; fx owns its writable profile.
{inputs, ...}: {
  den.aspects.features.coding-agents.homeManager = {
    lib,
    pkgs,
    ...
  }: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [../../_modules/home-manager/fx.nix];
    home.packages = [packages.hax];
    home.file.".pi/agent/pi-fff.json".text = builtins.toJSON {
      enableHomeDirScanning = false;
      enableFsRootScanning = false;
      followSymlinks = false;
    };
    programs = {
      fx = {
        enable = true;
        package = packages.fx;
        autoUpgrade = false;
      };
      pi-coding-agent = {
        enable = true;
        package = packages.pi;
        settings = {
          lastChangelogVersion = lib.getVersion packages.pi;
          theme = "ghostty-sync-4a78f491";
          defaultProvider = "openai-codex";
          defaultModel = "gpt-6.1-sol";
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
            "openai-codex/gpt-6.1-sol"
            "openai-codex/gpt-6-luna"
          ];
          tuiMode = "fullscreen";
          modelThinkingLevels = {
            "openai-codex/gpt-6-astra" = "high";
            "openai-codex/gpt-6.1-sol" = "high";
            "openai-codex/gpt-6-luna" = "medium";
          };
        };
      };
      herdr = {
        enable = true;
        package = packages.herdr;
        settings = {
          theme = {
            auto_switch = true;
            name = "terminal";
          };
          onboarding = false;
        };
      };
      opencode = {
        enable = true;
        package = packages.opencode2;
        tui.theme = "system";
        settings = {
          autoupdate = true;
          autoshare = false;
          lsp = true;
        };
      };
    };
  };
}
