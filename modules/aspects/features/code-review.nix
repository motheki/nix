# Declarative modules for review tools that lack upstream HM support.
{inputs, ...}: {
  den.aspects.features.code-review.homeManager = {pkgs, ...}: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [../../_modules/home-manager/hunk.nix];
    programs = {
      hunk = {
        enable = true;
        package = packages.hunk;
        settings = {
          mode = "auto";
          theme = "night-owl-light";
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
    };
  };
}
