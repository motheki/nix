{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.marksman
      pkgs.nil
      pkgs.ruff
      pkgs.ruff-lsp
      pkgs.nodePackages_latest.prettier
    ];
    settings = {
      theme = "ayu_light";
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
