# The editor foundation is useful without the optional language-server groups.
{inputs, ...}: {
  den.aspects.features.editor-core.homeManager = {
    imports = [inputs.nixvim.homeModules.nixvim];
    programs.nixvim = {
      enable = true;
      enableMan = true;
      version.enableNixpkgsReleaseCheck = true;
      nixpkgs.useGlobalPackages = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      dependencies = {
        ripgrep.enable = true;
        fd.enable = true;
        tree-sitter.enable = true;
        nodejs.enable = true;
      };
      luaLoader.enable = true;
      performance = {
        byteCompileLua = {
          enable = true;
          configs = true;
          luaLib = true;
          nvimRuntime = true;
          plugins = true;
        };
        combinePlugins.enable = true;
      };
      lsp = {
        inlayHints.enable = true;
        codelens.enable = true;
        servers = {
          # Preserve server-specific root detection; a universal .git marker
          # otherwise attaches language servers at overly broad monorepo roots.
          "*".config = {
            packageFallback = true;
            capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
          };
          bashls.enable = true;
          markdown_oxide.enable = true;
          nixd.enable = true;
          stylua.enable = true;
          taplo.enable = true;
          yamlls.enable = true;
          nushell.enable = true;
        };
      };
      clipboard = {
        providers.pbcopy.enable = true;
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
            align = {};
            bracketed = {};
            bufremove = {};
            clue = {};
            colors = {};
            comment = {};
            completion = {};
            cursorword = {};
            diff = {};
            doc = {};
            files = {};
            fuzzy = {};
            git = {};
            hipatterns = {};
            icons = {};
            indentscope = {};
            keymap = {};
            map = {};
            operators = {};
            pairs = {};
            pick = {};
            sessions = {};
            snippets = {};
            splitjoin = {};
            statusline = {};
            starter = {};
            surround = {};
            tabline = {};
            trailspace = {};
            visits = {};
          };
        };
        lsp = {
          enable = true;
          autoLoad = true;
          inlayHints = true;
        };
        colorizer.enable = true;
        colorful-menu.enable = true;
        transparent.enable = true;
        direnv.enable = true;
        faster.enable = true;
        gitblame.enable = true;
        lspkind.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        smear-cursor.enable = true;
        notify = {
          enable = true;
          settings.background_colour = "#000000";
        };
        noice.enable = true;
        treesitter = {
          enable = true;
          folding.enable = false;
          settings = {
            # Grammars are installed declaratively, not mutated at runtime.
            autoInstall = false;
            highlight.enable = true;
          };
        };
        trouble.enable = true;
        jj.enable = true;
      };
      colorschemes.rose-pine = {
        enable = true;
        settings = {
          dark_variant = "moon";
          dim_inactive_windows = true;
          extend_background_behind_borders = true;
          variant = "auto";
          styles = {
            bold = true;
            italic = true;
            transparency = true;
          };
        };
      };
    };
  };
}
