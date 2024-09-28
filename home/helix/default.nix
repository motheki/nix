{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      nil
      nixfmt-rfc-style
      ruff
      pylyzer
      nodePackages_latest.prettier
      zls
      gopls
      nodePackages_latest.typescript-language-server
      nodePackages_latest.tailwindcss
      helix-gpt
      spectral-language-server
    ];
    languages = {
      language-server.ruff =  {
        command = "ruff";
        args = [ "server" ];
        config = {
          settings = {
            lineLength = 80;
            lint = {
              select = ["E4" "E7"];
              preview = true;
            };
            format = {
              preview = true;
            };
          };
        };
      };
      language = [
        {
          name = "zig";
          auto-format = true;
          language-servers = [ "zls" ];
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" "nixfmt-rfc-style" ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [ "ruff" "pylyzer" ];
        }
        {
          name = "go";
          auto-format = true;
          language-servers = [ "gopls" ];
        }
      ];
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
