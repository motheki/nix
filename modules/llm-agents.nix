{inputs, ...}: {
  den.aspects.profiles.llm-agents.homeManager = {pkgs, ...}: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = [packages.goose-cli];

    programs.opencode = {
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
}
