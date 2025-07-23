{
  pkgs,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
  };
  programs.mods = {
    enable = true;
  };
  programs.television = {
    enable = true;
  };
  programs.atuin = {
    enable = true;
    daemon = {
      enable = true;
    };
    settings = {
      search_mode = "skim";
      search_mode_shell_up_key_binding = "skim";
      style = "full";
      invert = false;
      enter_accept = true;
    };
  };
  programs.carapace = {
    enable = true;
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
  programs.skim = {enable = true;};
  programs.ripgrep = {
    package = pkgs.ripgrep-all;
    enable = true;
  };
  programs.nushell = {
    enable = true;
    plugins = with pkgs; [
      nushellPlugins.formats
      nushellPlugins.skim
      nushellPlugins.gstat
      nushellPlugins.highlight
      nushellPlugins.query
      nushellPlugins.polars
    ];
    package = pkgs.nushell;
    shellAliases = {
    };
    extraConfig = ''

      $env.config = {
        show_banner: false,
        edit_mode: vi,
      };
      let config = {
        use_ls_colors: true
      };
    '';
    extraEnv = ''
      $env.EDITOR = 'hx'
      $env.LS_COLORS = (vivid generate rose-pine-moon)
    '';
  };
  programs.zoxide = {enable = true;};
  programs.starship = {enable = true;};
  programs.thefuck = {enable = true;};
  programs.jq = {enable = true;};
  programs.tealdeer = {
    enable = true;
    settings = {updates = {auto_update = true;};};
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "greyscale";
      theme_background = false;
    };
  };
  programs.fish = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion = {enable = true;};
    history.ignoreAllDups = true;
    defaultKeymap = "viins";
    shellAliases = {
    };
    syntaxHighlighting = {enable = true;};
    initContent = lib.mkOrder 550 ''
      path+=('~/.cargo/bin')
      export LS_COLORS='$(vivid generate rose-pine-moon)'
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    '';
  };
}
