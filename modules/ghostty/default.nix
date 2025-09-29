{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "light:Rose Pine Dawn,dark:Rose Pine";
      font-size = 12;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      macos-icon = "paper";
      macos-icon-frame = "beige";
      background-opacity = 0.75;
      background-blur = true;
      window-height = 55;
      window-width = 140;
      auto-update = "download";
      auto-update-channel = "tip";
    };
  };
}
