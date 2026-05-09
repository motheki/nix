{ den, ... }:
{
  den.aspects.motheki.homeManager = { pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "light: Nord Light,dark: Nord";
      font-size = 16;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      background-opacity = 0.85;
      background-blur = true;
      window-height = 53;
      window-width = 160;
      window-inherit-working-directory = true;
      tab-inherit-working-directory = true;
      split-inherit-working-directory = true;
      #macos-icon = "paper";
      #macos-icon-frame = "beige";
      macos-titlebar-style = "transparent";
      auto-update = "download";
      auto-update-channel = "tip";
    };
  };
  };
}
