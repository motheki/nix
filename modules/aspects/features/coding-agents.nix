# Native modules manage configuration; fx owns its writable profile.
{inputs, ...}: {
  den.aspects.features.coding-agents.homeManager = {
    pkgs,
    ...
  }: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    programs = {
      claude-code = {
        enable = true;
        package = packages.claude-code;
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
