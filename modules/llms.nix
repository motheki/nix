_: {
  services.ollama = {
    enable = true;
  };
  programs.claude-code = {
    enable = true;
  };
  programs.codex = {
    enable = true;
  };
  programs.opencode = {
    enable = true;
    tui = {
      theme = "system";
    };
    settings = {
      autoupdate = true;
      autoshare = false;
    };
  };
}
