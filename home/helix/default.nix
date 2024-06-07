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
      };
    };
  };
}
