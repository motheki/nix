# Declarative modules for review tools that lack upstream HM support.
{inputs, ...}: {
  den.aspects.features.code-review.homeManager = {pkgs, ...}: let
    packages = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [../../_modules/home-manager/hunk.nix ../../_modules/home-manager/tuicr.nix];
    programs = {
      tuicr = {
        enable = true;
        package = packages.tuicr;
        settings = {
          # Match Ghostty's light/dark Rosé Pine pair. Set `theme` to either
          # "rose-pine-moon" or "rose-pine-dawn" to pin one variant instead.
          theme_dark = "rose-pine-moon";
          theme_light = "rose-pine-dawn";
          appearance = "system";
          transparent_background = true;
        };
      };
      hunk = {
        enable = true;
        package = packages.hunk;
        settings = {
          mode = "auto";
          theme = "rose-pine-dawn";
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
