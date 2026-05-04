{ den, ... }:
{
  den.aspects.motheki.homeManager = {
    services.ollama = {
      enable = true;
    };
    programs = {
      claude-code = {
        enable = false;
      };
      codex = {
        enable = true;
      };
      opencode = {
        enableMcpIntegration = true;
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
    };
  };
}
