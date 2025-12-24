{ pkgs, ... }:
{
  programs.nixvim = {
    package = pkgs.neovim-unwrapped;
    enable = true;
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
          config = {
            cmd = [
              "astro-ls"
              "--stdio"
            ];
            filetypes = [
              "astro"
            ];
            root_markers = [
              "package.json"
              "tsconfig.json"
              "jsconfig.json"
            ];
          };
        };
        bashls = {
          enable = true;
          config = {
            cmd = [
              "bash-language-server"
              "start"
            ];
            filetypes = [
              "bash"
              "sh"
            ];
          };
        };
        gopls = {
          enable = true;
          config = {
            cmd = [
              "gopls"
            ];
            filetypes = [
              "go"
              "gomod"
              "gowork"
              "gotmpl"
            ];
          };
        };
        html = {
          enable = true;
          config = {
            cmd = [
              "vscode-html-language-server"
              "--stdio"
            ];
            filetypes = [
              "html"
            ];
            root_markers = [
              "package.json"
            ];
            init_options = {
              configurationSection = [
                "html"
                "css"
                "javascript"
              ];
              embeddedLanguages = {
                css = true;
                javascript = true;
              };
              provideFormatter = true;
            };
          };
        };
        jsonls = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
          config = {
            autoArchive = true;
          };
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
        pyrefly = {
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
      colorizer = {
        enable = true;
      };
      colorful-menu = {
        enable = true;
      };
      conform-nvim = {
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
      lsp = {
        enable = true;
      };
      lsp-format = {
        enable = true;
      };
      lspkind = {
        enable = true;
      };
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = { };
          align = { };
          sessions = { };
          visits = { };
          bracketed = { };
          bufremove = { };
          clue = { };
          colors = { };
          hipatterns = { };
          cursorword = { };
          completion = { };
          pick = { };
          diff = { };
          doc = { };
          extra = { };
          git = { };
          fuzzy = { };
          files = { };
          indentscope = { };
          jump2d = { };
          map = { };
          move = { };
          splitjoin = { };
          starter = {
            header = ''
              ░░░    ░░ ░░ ░░   ░░ ░░    ░░ ░░ ░░░    ░░░
              ▒▒▒▒   ▒▒ ▒▒  ▒▒ ▒▒  ▒▒    ▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒
              ▒▒ ▒▒  ▒▒ ▒▒   ▒▒▒   ▒▒    ▒▒ ▒▒ ▒▒ ▒▒▒▒ ▒▒
              ▓▓  ▓▓ ▓▓ ▓▓  ▓▓ ▓▓   ▓▓  ▓▓  ▓▓ ▓▓  ▓▓  ▓▓
              ██   ████ ██ ██   ██   ████   ██ ██      ██
              						'';
          };
          pairs = { };
          statusline = { };
          surround = { };
          tabline = { };
          snippets = { };
          trailspace = { };
        };
      };
      nix-develop = {
        enable = true;
      };
      noice = {
        enable = true;
      };
      none-ls = {
        enable = true;
      };
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
        };
      };
      telescope = {
        enable = true;
      };
      fff = {
        enable = false;
      };
      treesitter = {
        enable = true;
        folding = {
        enable = true;
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
      smear-cursor = {
        enable = true;
      };
    };
    colorschemes = {
      rose-pine = {
        enable = true;
        settings = {
          styles = {
            transparency = true;
          };
        };
      };
    };
  };
}
