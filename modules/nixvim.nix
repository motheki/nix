{
  pkgs,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    nixpkgs = {
      useGlobalPackages = true;
    };
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    dependencies = {
      ripgrep = {
        enable = true;
      };
      fd = {
        enable = true;
      };
      tree-sitter = {
        enable = true;
      };
      nodejs = {
        enable = true;
      };
    };
    luaLoader = {
      enable = true;
    };
    performance = {
      byteCompileLua = {
        enable = true;
        configs = true;
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
        "*" = {
          config = {
            packageFallback = true;
            capabilities = {
              textDocument = {
                semanticTokens = {
                  multilineTokenSupport = true;
                };
              };
            };
            root_markers = [
              ".git"
            ];
          };
        };
        astro = {
          enable = true;
        };
        bashls = {
          enable = true;
        };
        markdown_oxide = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        nushell = {
          enable = true;
        };
        oxfmt = {
          enable = true;
        };
        oxlint = {
          enable = true;
          config = {
            cmd = [
              "oxlint"
              "--lsp"
            ];
          };
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
        rust_analyzer = {
          enable = true;
        };
        sqls = {
          enable = true;
        };
        tsgo = {
          enable = false;
        };
        ts_ls = {
          enable = true;
        };
        statix = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
        nixd = {
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
      register = "unnamedplus";
    };
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      smarttab = true;
      smartindent = true;
      autowriteall = true;
      expandtab = true;
      undofile = true;
    };
    plugins = {
      blink-cmp = {
        enable = true;
      };
      blink-compat = {
        enable = true;
      };
      blink-indent = {
        enable = true;
      };
      blink-pairs = {
        enable = true;
      };
      bufferline = {
        enable = true;
      };
      lsp = {
        enable = true;
      };
      lsp-format = {
        enable = true;
      };
      colorizer = {
        enable = true;
      };
      colorful-menu = {
        enable = true;
      };
      transparent = {
        enable = true;
      };
      direnv = {
        enable = true;
      };
      faster = {
        enable = true;
      };
      gitblame = {
        enable = true;
      };
      glow = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };
      opencode = {
        enable = true;
      };
      lspkind = {
        enable = true;
      };
      nix = {
        enable = true;
      };
      nix-develop = {
        enable = true;
      };
      smear-cursor = {
        enable = true;
      };
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
        };
      };
      noice = {
        enable = true;
      };
      none-ls = {
        enable = true;
      };
      tv = {
        enable = true;
      };
      treesitter = {
        enable = true;
        folding = {
          enable = false;
        };
        settings = {
          autoInstall = true;
          highlight = {
            enable = true;
          };
        };
      };
      trouble = {
        enable = true;
      };
      which-key = {
        enable = true;
      };
    };
    colorschemes = {
      nord = {
        enable = true;
        lazyload = {
          enable = false;
        };
        settings = {
          borders = true;
          disable_background = true;
          cursorline_transparent = true;
          uniform_diff_background = true;
        };
      };
    };
  };
}
