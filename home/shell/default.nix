{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    settings = {
      search_mode = "skim";
      search_mode_shell_up_key_binding = "skim";
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
    config = {theme = "Nord";};
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {enable = true;};
    silent = true;
  };
  programs.skim = {enable = true;};
  programs.eza = {
    enable = true;
    icons = "auto";
    extraOptions = ["--classify=always" "--color=always" "--all"];
  };
  programs.ripgrep = {enable = true;};
  programs.nushell = {
    enable = true;
    plugins = [pkgs.nushellPlugins.formats pkgs.nushellPlugins.skim pkgs.nushellPlugins.gstat pkgs.nushellPlugins.highlight pkgs.nushellPlugins.query pkgs.nushellPlugins.polars];
    package = pkgs.nushell;
    shellAliases = {
    };
    extraConfig = ''
      let nord_theme = {
        binary: '#b48ead'
        block: '#81a1c1'
        cell-path: '#e5e9f0'
        closure: '#88c0d0'
        custom: '#8fbcbb'
        duration: '#ebcb8b'
        float: '#bf616a'
        glob: '#8fbcbb'
        int: '#b48ead'
        list: '#88c0d0'
        nothing: '#bf616a'
        range: '#ebcb8b'
        record: '#88c0d0'
        string: '#a3be8c'

        shape_and: { fg: '#b48ead' attr: 'b' }
        shape_binary: { fg: '#b48ead' attr: 'b' }
        shape_block: { fg: '#81a1c1' attr: 'b' }
        shape_bool: '#88c0d0'
        shape_closure: { fg: '#88c0d0' attr: 'b' }
        shape_custom: '#a3be8c'
        shape_datetime: { fg: '#88c0d0' attr: 'b' }
        shape_directory: '#88c0d0'
        shape_external: '#88c0d0'
        shape_external_resolved: '#88c0d0'
        shape_externalarg: { fg: '#a3be8c' attr: 'b' }
        shape_filepath: '#88c0d0'
        shape_flag: { fg: '#81a1c1' attr: 'b' }
        shape_float: { fg: '#bf616a' attr: 'b' }
        shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
        shape_glob_interpolation: { fg: '#88c0d0' attr: 'b' }
        shape_globpattern: { fg: '#88c0d0' attr: 'b' }
        shape_int: { fg: '#b48ead' attr: 'b' }
        shape_internalcall: { fg: '#88c0d0' attr: 'b' }
        shape_keyword: { fg: '#b48ead' attr: 'b' }
        shape_list: { fg: '#88c0d0' attr: 'b' }
        shape_literal: '#81a1c1'
        shape_match_pattern: '#a3be8c'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#bf616a'
        shape_operator: '#ebcb8b'
        shape_or: { fg: '#b48ead' attr: 'b' }
        shape_pipe: { fg: '#b48ead' attr: 'b' }
        shape_range: { fg: '#ebcb8b' attr: 'b' }
        shape_raw_string: { fg: '#8fbcbb' attr: 'b' }
        shape_record: { fg: '#88c0d0' attr: 'b' }
        shape_redirection: { fg: '#b48ead' attr: 'b' }
        shape_signature: { fg: '#a3be8c' attr: 'b' }
        shape_string: '#a3be8c'
        shape_string_interpolation: { fg: '#88c0d0' attr: 'b' }
        shape_table: { fg: '#81a1c1' attr: 'b' }
        shape_vardecl: { fg: '#81a1c1' attr: 'u' }
        shape_variable: '#b48ead'

        foreground: '#e5e9f0'
        background: '#2e3440'
        cursor: '#e5e9f0'

        empty: '#81a1c1'
        header: { fg: '#a3be8c' attr: 'b' }
        hints: '#4c566a'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#a3be8c' attr: 'b' }
        search_result: { fg: '#bf616a' bg: '#e5e9f0' }
        separator: '#e5e9f0'
      }

      $env.config = {
        show_banner: false,
        edit_mode: vi,
        color_config: $nord_theme,
      };
      $env.LS_COLORS = (vivid generate nord | str trim);
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
      color_theme = "nord";
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
      export LS_COLORS='$(vivid generate nord)'
      export HANDLER='copilot'
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      source <(carapace _carapace)
    '';
  };
}
