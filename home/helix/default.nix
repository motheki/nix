{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      nil
      nixpkgs-fmt
      ruff
      nodePackages_latest.prettier
      zls
      nodePackages_latest.typescript-language-server
      nodePackages_latest.tailwindcss
      helix-gpt
      spectral-language-server
    ];
    languages = {
      language-server.ruff = with pkgs.ruff; {
        command = "ruff";
        args = ["server"];
      };
      language = [{
        name = "python";
        auto-format = true;
        language-servers = ["ruff"];
      }];
    };
    settings = {
      theme = "ayu_dark_clear";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        lsp.display-inlay-hints = true;
        lsp.snippets = true;
        cursor-shape.insert = "bar";
        true-color = true;
        bufferline = "multiple";
        insert-final-newline = false;
        popup-border = "all";
      };
    };
  };
}
