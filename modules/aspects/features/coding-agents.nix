# Home Manager owns CLI installation and configuration from llm-agents packages.
{inputs, ...}: {
  den.aspects.features.coding-agents.homeManager = {pkgs, ...}: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [../../_modules/home-manager/fx.nix];
    # Flake package exports are build targets; Home Manager installs the CLIs.
    home.packages = [packages.t3code-desktop packages.hax];

    programs = {
      t3code = {
        enable = true;
        package = packages.t3code;
      };
      opencode = {
        enable = true;
        package = packages.opencode2;
      };
      fx = {
        enable = true;
        package = packages.fx;
      };
      codex = {
        enable = true;
        package = packages.codex;
        mutableSettings = true;
        settings = {
          model = "gpt-6.1-sol";
          model_reasoning_effort = "high";
          sandbox_mode = "danger-full-access";
          approval_policy = "never";
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
    };
  };
}
