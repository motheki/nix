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
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        auto-save = {
          focus-lost = true;
          after-delay ={
            enable = true;
          };
        };
        whitespace ={
          render = "all";
          characters = {
            space = "·";
            nbsp = "⍽";
            nnbsp = "␣";
            tab = "→";
            newline = "⏎";
            tabpad = "·";
          };
        };
        indent-guides = {
          render = true;
          character = "▏"; # Some characters that work well: "▏", "┆", "┊", "⸽"
          skip-levels = 1;
        };
        soft-wrap = {
          enable = true;
        };
        scrolloff = 2;
        cursorline = true;
        cursorcolumn = true;
        line-number = "relative";
        smart-tab = {
          enable = true;
        };
        color-modes = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
          snippets = true;
        };
        true-color = true;
        bufferline = "multiple";
        insert-final-newline = true;
        popup-border = "all";
      };
    };
  };
}
