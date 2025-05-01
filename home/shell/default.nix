{pkgs, ...}: {
  programs.atuin = {
    daemon.enable = true;
    enable = true;
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
    config = {theme = "base16";};
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {enable = true;};
    silent = true;
  };
  programs.skim = {enable = true;};
  programs.eza = {
    enable = true;
    enableNushellIntegration = false;
    icons = "always";
    git = true;
    colors = "always";
    extraOptions = ["--classify=always" "--all"];
  };
  programs.ripgrep = {enable = true;};
  programs.nushell = {
    enable = true;
    #plugins = with pkgs; [
    #  nushellPlugins.formats
    #  nushellPlugins.skim
    #  nushellPlugins.gstat
    #  nushellPlugins.highlight
    #  nushellPlugins.query
    #  nushellPlugins.polars
    #];
    package = pkgs.nushell;
    shellAliases = {
    };
    extraConfig = ''

      $env.config = {
        show_banner: false,
        edit_mode: vi,
      };
      $env.LS_COLORS = (vivid generate rose-pine-moon | str trim);
      let config = {
        use_ls_colors: true
      };
      source ~/.cache/carapace/init.nu
    '';
    extraEnv = ''
      $env.PATH = ($env.PATH | split row (char esep) | prepend '~/.cargo/bin')
      $env.EDITOR = 'hx'
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
      $env.HANDLER = 'copilot'
      mkdir ~/.cache/carapace
      carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
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
      color_theme = "rose-pine-moon";
      theme_background = false;
    };
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
    initExtraBeforeCompInit = ''
      path+=('~/.cargo/bin')
      export LS_COLORS='$(vivid generate rose-pine-moon)'
      export HANDLER='copilot'
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      source <(carapace _carapace)
    '';
  };
}
