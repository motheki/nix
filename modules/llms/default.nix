{...}: {
  services.ollama = {
    enable = true;
  };
  programs.mods = {
    enable = true;
    settings = {
      default-api = "ollama";
      default-model = "gemma3";
      format-text = {
        markdown = "Format the response as markdown without enclosing backticks.";
        json = "Format the response as json without enclosing backticks.";
      };
      format = true;
      roles = {
        "default" = [];
      };
      role = "default";
      raw = false;
      quiet = false;
      temp = 1.0;
      topp = 1.0;
      topk = 50;
      no-limit = false;
      word-wrap = 120;
      include-prompt-args = false;
      include-prompt = 0;
      max-retries = 5;
      fanciness = 10;
      status-text = "Generating";
      theme = "base16";
      max-input-chars = 12250;
      max-completion-tokens = 100;
      apis = {
        ollama = {
          base-url = "http://localhost:11434";
          models = {
            "gemma3:12b-it-qat" = {
              aliases = ["gemma3"];
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
