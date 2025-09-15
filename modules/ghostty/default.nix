{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "light:rose-pine-dawn,dark:rose-pine";
      font-size = 12;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      auto-update = "download";
      auto-update-channel = "tip";
      background-opacity = 0.75;
      background-blur = true;
      window-height = 55;
      window-width = 140;
    };
  };
}
