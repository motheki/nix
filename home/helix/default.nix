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
      ruff-lsp
      nodePackages_latest.prettier
      zls
      nodePackages_latest.typescript-language-server
      nodePackages_latest.tailwindcss
      helix-gpt
    ];
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
