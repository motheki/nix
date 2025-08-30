{pkgs, ...}: {
  services.ollama = {
    enable = true;
  };
  programs.mods = {
    enable = true;
  };
  programs.fd = {
    enable = true;
  };
  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.yt-dlp = {
    enable = true;
    settings = {
      paths = "/Volumes/mothekis_drive/Videos/Youtube/";
      embed-thumbnail = true;
      embed-metadata = true;
      sponsorblock-remove = "selfpromo,interaction,sponsor";
      progress = true;
      quiet = true;
      output = "%(title)s.%(ext)s";
      extractor-args = "youtube:player-client=web,android,ios";
      video-multistreams = true;
      audio-multistreams = true;
    };
  };
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      prettybat
      batwatch
      batgrep
      batdiff
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {enable = true;};
    silent = true;
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.zoxide = {enable = true;};
  programs.starship = {
    enable = true;
  };
  programs.jq = {enable = true;};
  programs.tealdeer = {
    enable = true;
    settings = {updates = {auto_update = true;};};
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "rose-pine-dawn";
      theme_background = false;
    };
  };
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    syntaxHighlighting = {
      enable = true;
    };
  };
}
