{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "light:Rose Pine Dawn,dark:Rose Pine Moon";
      font-size = 12;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      background-opacity = 0.85;
      background-blur = true;
      window-height = 55;
      window-width = 140;
      window-inherit-working-directory = false;
      #macos-icon = "paper";
      #macos-icon-frame = "beige";
      macos-titlebar-style = "transparent";
      auto-update = "download";
      auto-update-channel = "tip";
    };
  };
}
