{pkgs, ...}: {
  programs.helix = {
    package = pkgs.evil-helix;
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      nil
      lua-language-server
      cmake-language-server
      nixfmt-rfc-style
      swift-format
      lldb
      ty
      ruff
      astro-language-server
      nimlangserver
      biome
      zig
      bash-language-server
      zls
      gopls
      biome
      alejandra
      helix-gpt
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-json-languageserver
      nodePackages_latest.tailwindcss
      yaml-language-server
      rust-analyzer
      superhtml
      spectral-language-server
      sass
      rubyPackages.solargraph
      haskellPackages.lsp
      taplo
    ];
    languages = {
      language-server.ty = {
        language-id = "python";
        command = "ty";
        args = ["server"];
      };
      language-server.ruff = {
        language-id = "python";
        command = "ruff";
        args = ["server"];
      };
      language-server.gpt = {
        command = "helix-gpt";
      };
      language-server.ts = {
        command = "typescript-language-server";
        args = ["--stdia"];
        language-id = "javascript";
      };
      language = [
        {
          name = "toml";
          auto-format = true;
          language-servers = ["taplo"];
        }
        {
          name = "html";
          auto-format = true;
          language-servers = ["superhtml"];
        }
        {
          name = "ruby";
          auto-format = true;
          language-servers = ["rubyPackages.solargraph"];
        }
        {
          name = "nim";
          auto-format = true;
          language-servers = ["nimlangserver"];
        }
        {
          name = "haskell";
          auto-format = true;
          language-servers = ["haskellPackages.lsp"];
        }
        {
          name = "cmake";
          auto-format = true;
          language-servers = ["cmake-language-server"];
        }
        {
          name = "lua";
          auto-format = true;
          language-servers = ["lua-language-server"];
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = ["astro-language-server"];
        }
        {
          name = "json";
          auto-format = true;
          language-servers = ["nodePackages_latest.vscode-json-languageserver"];
        }
        {
          name = "css";
          auto-format = true;
          language-servers = ["nodePackages_latest.tailwindcss"];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = ["ts" "gpt"];
          formatter = {
            command = "biome";
            args = ["check" "--write"];
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer" "lldb"];
        }
        {
          name = "yaml";
          auto-format = true;
          language-servers = ["yaml-language-server"];
        }
        {
          name = "zig";
          auto-format = true;
          language-servers = ["zls" "lldb"];
          formatter = {
            command = "zig";
            args = ["fmt" "--ast-check"];
          };
        }
        {
          name = "bash";
          auto-format = true;
          language-servers = ["bash-language-server"];
        }
        {
          name = "nix";
          auto-format = true;
          formatter = ["alejandra"];
          language-servers = ["nil"];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["ty" "ruff"];
          formatter = {
            command = "ruff";
            args = ["format"];
          };
        }
        {
          name = "swift";
          auto-format = true;
          language-servers = ["sourcekit-lsp" "swift-formatter" "lldb"];
          formatter = {
            command = "swift-format";
            args = ["-p" "-r"];
          };
        }
        {
          name = "go";
          auto-format = true;
          language-servers = ["gopls"];
        }
      ];
    };
    settings = {
      theme = "base16_default_clear";
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
