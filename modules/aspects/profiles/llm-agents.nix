# AI coding tools are consumed from their OmniFlake entry. No overlay is needed
# because these packages do not need to become part of the shared pkgs.
{inputs, ...}: {
  den.aspects.profiles.llm-agents.homeManager = {pkgs, ...}: let
    packages =
      inputs.omniflake.flakes."github:numtide/llm-agents.nix".packages.${pkgs.stdenv.hostPlatform.system};
  in {
    # Pi uses Node and Bun from the normal user profile configured by the
    # development profile, rather than a private wrapper or activation hack.
    home.packages = with packages; [
      fx
      tuicr
    ];

    programs = {
      codex = {
        enable = true;
        package = packages.codex;
      };
      pi-coding-agent = {
        enable = true;
        package = packages.pi;
      };
      herdr = {
        enable = true;
        package = packages.herdr;
        settings.theme = {
          auto_switch = false;
          name = "terminal";
        };
      };
      opencode = {
        enable = true;
        package = packages.opencode;
        tui.theme = "system";
        settings = {
          autoupdate = false;
          autoshare = false;
          lsp = true;
        };
      };
    };
  };
}
