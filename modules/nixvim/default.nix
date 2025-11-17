{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    performance = {
      byteCompileLua = {
        enable = true;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins = {
        enable = true;
      };
    };
    lsp = {
      inlayHints = {
        enable = true;
      };
      servers = {
        astro = {
          enable = true;
        };
        bashls = {
          enable = true;
        };
        biome = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        html = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
        nixd = {
          enable = true;
        };
        nushell = {
          enable = true;
        };
        oxlint = {
          enable = true;
        };
        phan = {
          enable = true;
        };
        postgres_lsp = {
          enable = true;
        };
        ruby_lsp = {
          enable = true;
        };
        ruff = {
          enable = true;
        };
        rust_analyzer = {
          enable = true;
        };
        sourcekit = {
          enable = true;
        };
        sqls = {
          enable = true;
        };
        statix = {
          enable = true;
        };
        stylint_lsp = {
          enable = true;
        };
        stylua = {
          enable = true;
        };
        superhtml = {
          enable = true;
        };
        svelte = {
          enable = true;
        };
        tailwindcss = {
          enable = true;
        };
        taplo = {
          enable = true;
        };
        tsgo = {
          enable = true;
        };
        ty = {
          enable = true;
        };
        yamlls = {
          enable = true;
        };
        zls = {
          enable = true;
        };
      };
    };
    clipboard = {
      providers = {
        pbcopy = {
          enable = true;
        };
      };
    };
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      smarttab = true;
    };
    plugins = {
      lspconfig = {
        enable = true;
      };
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = {
            style = "glyph";
            default = {};
            directory = {};
            extension = {};
            file = {};
            filetype = {};
            lsp = {};
            os = {};
          };
        };
      };
      smear-cursor = {
        enable = true;
      };
      neoscroll = {
        enable = true;
      };
      mini-basics = {
        enable = true;
      };
      mini-bracketed = {
        enable = true;
      };
      mini-bufremove = {
        enable = true;
      };
      mini-clue = {
        enable = true;
      };
      mini-colors = {
        enable = true;
      };
      mini-cursorword = {
        enable = true;
      };
      mini-diff = {
        enable = true;
      };
      mini-doc = {
        enable = true;
      };
      mini-extra = {
        enable = true;
      };
      mini-git = {
        enable = true;
      };
      mini-fuzzy = {
        enable = true;
      };
      mini-files = {
        enable = true;
      };
      mini-jump2d = {
        enable = true;
      };
      mini-map = {
        enable = true;
      };
      mini-move = {
        enable = true;
      };
      mini-splitjoin = {
        enable = true;
      };
      mini-statusline = {
        enable = true;
      };
      mini-surround = {
        enable = true;
      };
      mini-tabline = {
        enable = true;
      };
      mini-trailspace = {
        enable = true;
      };
      nix = {
      	enable = true;
      };
      glow = {
        enable = true;
      };
      lspkind = {
        enable = true;
      };
      neo-tree = {
        enable = true;
      };
      telescope = {
        enable = true;
      };
    };
    colorschemes = {
      rose-pine = {
        enable = true;
        settings = {
          extend_background_behind_borders = false;
        };
      };
    };
  };
}
