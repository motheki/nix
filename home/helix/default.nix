{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      nil
      lua-language-server
      cmake-language-server
      nixfmt-rfc-style
      astro-language-server
      nodePackages_latest.prettier
      bash-language-server
      zls
      pylyzer
      gopls
      alejandra
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-json-languageserver
      nodePackages_latest.tailwindcss
      helix-gpt
      yaml-language-server
      rust-analyzer
      spectral-language-server
      taplo
    ];
    languages = {
      language-server.helix-gpt = {
        command = "helix-gpt";
      };
      language-server.ruff = {
        command = "ruff";
        args = ["server"];
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
          name = "toml";
          auto-format = true;
          language-servers = ["taplo" "helix-gpt"];
        }
        {
          name = "cmake";
          auto-format = true;
          language-servers = ["helix-gpt" "cmake-language-server"];
        }
        {
          name = "lua";
          auto-format = true;
          language-servers = ["lua-language-server" "helix-gpt"];
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = ["astro-language-server" "helix-gpt"];
        }
        {
          name = "json";
          auto-format = true;
          language-servers = ["nodePackages_latest.vscode-json-languageserver" "helix-gpt"];
        }
        {
          name = "css";
          auto-format = true;
          language-servers = ["helix-gpt" "nodePackages_latest.tailwindcss"];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer" "helix-gpt"];
        }
        {
          name = "yaml";
          auto-format = true;
          language-servers = ["yaml-language-server" "helix-gpt"];
        }
        {
          name = "zig";
          auto-format = true;
          language-servers = ["zls" "helix-gpt"];
        }
        {
          name = "bash";
          auto-format = true;
          language-servers = ["bash-language-server" "helix-gpt"];
        }
        {
          name = "nix";
          auto-format = true;
          formatter = ["alejandra"];
          language-servers = ["nil" "helix-gpt"];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["helix-gpt" "pylyzer"];
        }
        {
          name = "swift";
          auto-format = true;
          language-servers = ["sourcekit-lsp" "swift-formatter"];
        }
        {
          name = "go";
          auto-format = true;
          language-servers = ["gopls" "helix-gpt"];
        }
      ];
    };
    settings = {
      theme = "nord_dark_clear";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
          };
        };
        whitespace = {
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
