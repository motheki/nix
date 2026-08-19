# AI coding tools are consumed directly from their source flake. No overlay is
# needed because these packages do not need to become part of the shared pkgs.
{ inputs, ... }: {
  den.aspects.profiles.llm-agents.homeManager =
    { pkgs, ... }:
    let
      packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      # Pi uses Node and Bun from the normal user profile configured by the
      # development profile, rather than a private wrapper or activation hack.
      home.packages = [
        packages.goose-cli
        packages.pi
      ];

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
