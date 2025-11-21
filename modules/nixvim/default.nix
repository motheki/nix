{ ... }:
{
  programs.nixvim = {
    enable = true;
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
          packageFallback = true;
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
    };
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      smarttab = true;
    };
    plugins = {
      blame = {
        enable = true;
      };
      lspconfig = {
        enable = true;
      };
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = {
            style = "glyph";
            default = { };
            directory = { };
            extension = { };
            file = { };
            filetype = { };
            lsp = { };
            os = { };
          };
        };
      };
      mini-basics = {
        enable = true;
      };
      mini-align = {
        enable = true;
      };
      mini-icons = {
        enable = true;
      };
      mini-sessions = {
        enable = true;
      };
      mini-visits = {
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
      mini-hipatterns = {
        enable = true;
      };
      mini-cursorword = {
        enable = true;
      };
      mini-completion = {
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
      mini-indentscope = {
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
      mini-starter = {
        enable = true;
        settings = {
          header = ''
						░░░    ░░ ░░ ░░   ░░ ░░    ░░ ░░ ░░░    ░░░
						▒▒▒▒   ▒▒ ▒▒  ▒▒ ▒▒  ▒▒    ▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒
						▒▒ ▒▒  ▒▒ ▒▒   ▒▒▒   ▒▒    ▒▒ ▒▒ ▒▒ ▒▒▒▒ ▒▒
						▓▓  ▓▓ ▓▓ ▓▓  ▓▓ ▓▓   ▓▓  ▓▓  ▓▓ ▓▓  ▓▓  ▓▓
						██   ████ ██ ██   ██   ████   ██ ██      ██
					'';
        };
      };
      mini-pairs = {
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
      mini-snippets = {
        enable = true;
      };
      mini-trailspace = {
        enable = true;
      };
      lspkind = {
        enable = true;
      };
      telescope = {
        enable = true;
      };
      smear-cursor = {
        enable = true;
      };
      neoscroll = {
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
