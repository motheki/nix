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
    extraPackages = with pkgs.bat-extras; [batman batgrep prettybat];
    config = {theme = "Dracula";};
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {enable = true;};
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
    package = pkgs.nushell;
    extraConfig = ''
      let ayu_light_theme = {
         # color for nushell primitives
        separator: "#ffffff"
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: "#b8e532"
        empty: "#41a6d9"
        bool: "#ffffff"
        int: "#ffffff"
        filesize: "#ffffff"
        duration: "#ffffff"
        date: "#ffffff"
        range: "#ffffff"
        float: "#ffffff"
        string: "#ffffff"
        nothing: "#ffffff"
        binary: "#ffffff"
        cellpath: "#ffffff"
        row_index: "#b8e532"
        record: "#ffffff"
        list: "#ffffff"
        block: "#ffffff"
        hints: "#323232"

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: "#ffa3aa"
        shape_bool: "#7ff0cb"
        shape_int: "#ffa3aa"
        shape_float: "#ffa3aa"
        shape_range: "#ffc849"
        shape_internalcall: "#7ff0cb"
        shape_external: "#4cbe99"
        shape_externalarg: "#b8e532"
        shape_literal: "#41a6d9"
        shape_operator: "#f19618"
        shape_signature: "#b8e532"
        shape_string: "#86b200"
        shape_string_interpolation: "#7ff0cb"
        shape_datetime: "#7ff0cb"
        shape_list: "#7ff0cb"
        shape_table: "#73d7ff"
        shape_record: "#7ff0cb"
        shape_block: "#73d7ff"
        shape_filepath: "#4cbe99"
        shape_globpattern: "#7ff0cb"
        shape_variable: "#f07078"
        shape_flag: "#73d7ff"
        shape_custom: "#86b200"
        shape_nothing: "#7ff0cb"
      }
      let ayu_theme = {
        # color for nushell primitives
        separator: "#ffffff"
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: "#e9fe83"
        empty: "#36a3d9"
        bool: "#ffffff"
        int: "#ffffff"
        filesize: "#ffffff"
        duration: "#ffffff"
        date: "#ffffff"
        range: "#ffffff"
        float: "#ffffff"
        string: "#ffffff"
        nothing: "#ffffff"
        binary: "#ffffff"
        cellpath: "#ffffff"
        row_index: "#e9fe83"
        record: "#ffffff"
        list: "#ffffff"
        block: "#ffffff"
        hints: "#323232"
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: "#ffa3aa"
        shape_bool: "#c7fffc"
        shape_int: "#ffa3aa"
        shape_float: "#ffa3aa"
        shape_range: "#fff778"
        shape_internalcall: "#c7fffc"
        shape_external: "#95e5cb"
        shape_externalarg: "#e9fe83"
        shape_literal: "#36a3d9"
        shape_operator: "#e6c446"
        shape_signature: "#e9fe83"
        shape_string: "#b8cc52"
        shape_string_interpolation: "#c7fffc"
        shape_datetime: "#c7fffc"
        shape_list: "#c7fffc"
        shape_table: "#68d4ff"
        shape_record: "#c7fffc"
        shape_block: "#68d4ff"
        shape_filepath: "#95e5cb"
        shape_globpattern: "#c7fffc"
        shape_variable: "#f07078"
        shape_flag: "#68d4ff"
        shape_custom: "#b8cc52"
        shape_nothing: "#c7fffc"
      }
      $env.config = {
        show_banner: false,
        edit_mode: vi,
      };
      $env.LS_COLORS = (vivid generate nord | str trim);
      let config = {
        use_ls_colors: true
      };
      source ~/.cache/carapace/init.nu
    '';
    extraEnv = ''
      $env.EDITOR = 'hx'
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
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
    syntaxHighlighting = {enable = true;};
    initExtra = ''
      export LS_COLORS='$(vivid generate nord)'
      export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      source <(carapace _carapace)
    '';
  };
}
