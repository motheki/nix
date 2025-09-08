{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "rose-pine-dawn";
      font-size = 12;
      font-family = "CommitMonoMotheki";
      cursor-style = "bar";
      auto-update = "download";
      auto-update-channel = "tip";
      background-opacity = 0.6;
      background-blur = true;
    };
  };
}
