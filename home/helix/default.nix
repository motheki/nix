{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.marksman
    ];
    settings = {
      theme = "nord";
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
