_: {
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
    mcp = {
      enable = true;
      servers = {
        jujutsu = {
          command = "npx";
          args = [
            "-y"
            "jj-mcp-server"
          ];
        };
      };
    };
    opencode = {
      enable = true;
      tui = {
        theme = "system";
      };
      settings = {
        autoupdate = true;
        autoshare = false;
      };
    };
  };
}
