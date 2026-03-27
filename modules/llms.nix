_: {
  services.ollama = {
    enable = true;
  };
  programs.claude-code = {
    enable = true;
  };
  programs.codex = {
    enable = false;
  };
  programs.opencode = {
    enable = false;
    settings = {
      theme = "system";
      autoupdate = true;
      autoshare = false;
    };
  };
}
