{...}: {
  programs.opencode = {
    enable = true;
    settings = {
      "provider" = {
        "ollama" = {
          "npm" = "@ai-sdk/openai-compatible";
          "name" = "Ollama (local)";
          "options" = {
            "baseURL" = "http://localhost:11434/v1";
          };
        };
        "models" = {
          "gemma3:12b-it-qat" = {
            "name" = "gemma3";
          };
        };
      };
    };
  };
}
