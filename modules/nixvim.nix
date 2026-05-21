{
  den,
  ...
}:
{
  den.aspects.motheki.homeManager =
    { pkgs, ... }:
    {
      programs.nixvim = {
        enable = true;
        version.enableNixpkgsReleaseCheck = false;
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
          mini = {
            enable = true;
            mockDevIcons = true;
            modules = {
              align = { };
              bracketed = { };
              bufremove = { };
              clue = { };
              colors = { };
              comment = { };
              completion = { };
              cursorword = { };
              diff = { };
              doc = { };
              files = { };
              fuzzy = { };
              git = { };
              hipatterns = { };
              icons = { };
              indentscope = { };
              keymap = { };
              map = { };
              operators = { };
              pairs = { };
              pick = { };
              sessions = { };
              snippets = { };
              splitjoin = { };
              statusline = { };
              starter = { };
              surround = { };
              tabline = { };
              trailspace = { };
              visits = { };
            };
          };
          lsp = {
            enable = true;
            autoLoad = true;
            inlayHints = true;
          };
          colorizer = {
            enable = true;
          };
          telescope = {
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
          fff = {
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
            settings = {
              borders = true;
              disable_background = true;
              italic = true;
            };
          };
          #ayu = {
          #  enable = true;
          #};
          #rose-pine = {
          #  enable = true;
          #  settings = {
          #    dark_variant = "moon";
          #    dim_inactive_windows = true;
          #    extend_background_behind_borders = true;
          #    variant = "auto";
          #    styles = {
          #      bold = true;
          #      italic = true;
          #      transparency = true;
          #    };
          #  };
          #};
        };
      };
    };
}
