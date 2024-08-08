{ pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    settings = {
      search_mode = "skim";
      search_mode_shell_up_key_binding = "skim";
      enter_accept = true;
    };
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
    extraPackages = with pkgs.bat-extras; [ batman batgrep prettybat ];
    config = {
      theme = "Nord";
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.skim = {
    enable = true;
  };
  programs.eza = {
    enable = true;
    extraOptions = [
      "--icons=always"
      "--classify=always"
      "--color=always"
      "--all"
    ];
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
  };
  programs.zoxide = {
    enable = true;
  };
  programs.starship = {
    enable = true;
  };
  programs.thefuck = {
    enable = true;
  };
  programs.jq = {
    enable = true;
  };
  programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "ayu";
      theme_background = false;
    };
  };
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    syntaxHighlighting = {
      enable = true;
    };
  };
}
