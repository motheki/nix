{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "light:Rose Pine Dawn,dark:Rose Pine";
      macos-icon = "paper";
      macos-icon-frame = "beige";
      font-size = 12;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      background-opacity = 0.75;
      background-blur = true;
      window-height = 55;
      window-width = 140;
    };
  };
}
