_: {
  den.aspects.motheki.homeManager = {
    services.ollama = {
      enable = false;
    };
    programs = {
      opencode = {
        enable = true;
        tui = {
          theme = "system";
        };
        settings = {
          autoupdate = true;
          autoshare = false;
          lsp = true;
        };
      };
      codex = {
        enable = false;
      };
    };
  };
}
