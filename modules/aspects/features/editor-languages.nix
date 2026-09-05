# Small, independently selectable groups; the workstation keeps existing languages.
{den, ...}: {
  den.aspects.features = {
    editor-web = {
      includes = [den.aspects.features.editor-core];
      homeManager.programs.nixvim.lsp.servers = {
        jsonls.enable = true;
        oxfmt.enable = true;
        oxlint = {
          enable = true;
          config.cmd = ["oxlint" "--lsp"];
        };
        superhtml.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
      };
    };
    editor-systems = {
      includes = [den.aspects.features.editor-core];
      homeManager.programs.nixvim.lsp.servers = {
        gopls.enable = true;
        rust_analyzer.enable = true;
        zls.enable = true;
      };
    };
    editor-data = {
      includes = [den.aspects.features.editor-core];
      homeManager.programs.nixvim.lsp.servers = {
        postgres_lsp.enable = true;
        sqls.enable = true;
      };
    };
    editor-scripting = {
      includes = [den.aspects.features.editor-core];
      homeManager.programs.nixvim.lsp.servers = {
        phan.enable = true;
        ruby_lsp.enable = true;
        ty.enable = true;
      };
    };
    # Optional alternatives, not loaded beside fff/mini.pick/mini.clue by default.
    editor-extras = {
      includes = [den.aspects.features.editor-core];
      homeManager.programs.nixvim.plugins = {
        telescope.enable = true;
        tv.enable = true;
        which-key.enable = true;
        none-ls.enable = true;
      };
    };
  };
}
