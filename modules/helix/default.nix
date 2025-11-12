{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      rose_pine_dawn_clear = {
        inherits = "rose_pine_dawn";
        "ui.background" = {
          fg = "foreground";
        };
      };
      rose_pine_moon_clear = {
        inherits = "rose_pine_moon";
        "ui.background" = {
          fg = "foreground";
        };
      };
      ayu_light_clear = {
        inherits = "ayu_light";
        "ui.background" = {
          fg = "foreground";
        };
      };
      ayu_mirage_clear = {
        inherits = "ayu_mirage";
        "ui.background" = {
          fg = "foreground";
        };
      };
      base16_default_light_clear = {
        inherits = "base16_default_light";
        "ui.background" = {
          fg = "foreground";
        };
      };
      catppuccin_latte_clear = {
        inherits = "catppuccin_latte";
        "ui.background" = {
          fg = "foreground";
        };
      };
      everforest_light_clear = {
        inherits = "everforest_light";
        "ui.background" = {
          fg = "foreground";
        };
      };
      nord_light_clear = {
        inherits = "nord_light";
        "ui.background" = {
          fg = "foreground";
        };
      };
      nord_clear = {
        inherits = "nord";
        "ui.background" = {
          fg = "foreground";
        };
      };
    };
    extraPackages = with pkgs; [
      nixd
      nil
      lua-language-server
      swift-format
      lldb
      ty
      ruff
      astro-language-server
      nimlangserver
      zig
      markdown-oxide
      bash-language-server
      zls
      gopls
      ocamlPackages.ocaml-lsp
      alejandra
      rPackages.air
      rubyPackages_3_4.ruby-lsp
      typescript-language-server
      vscode-json-languageserver
      vscode-css-languageserver
      yaml-language-server
      rust-analyzer
      superhtml
      phpactor
      spectral-language-server
      sass
      haskellPackages.lsp
      taplo
    ];
    languages = {
      language-server = {
        ruff-lsp = {
          language-id = "python";
          command = "ruff";
          args = ["server"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        phpactor-lsp = {
          language-id = "php";
          command = "phpactor";
          args = ["language-server"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        ty-lsp = {
          language-id = "python";
          command = "ty";
          args = ["server"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        md = {
          language-id = "markdown";
          command = "markdown-oxide";
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        ts-lsp = {
          language-id = "typescript";
          command = "typescript-language-server";
          args = ["--stdio"];
        };
        js-lsp = {
          language-id = "javascript";
          command = "typescript-language-server";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        astro-lsp = {
          language-id = "astro";
          command = "astro-ls";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        nixd-lsp = {
          language-id = "nix";
          command = "nixd";
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        nil-lsp = {
          language-id = "nix";
          command = "nil";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        json-lsp = {
          language-id = "json";
          command = "vscode-json-languageserver";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        yaml-lsp = {
          language-id = "yaml";
          command = "yaml-language-server";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        css-lsp = {
          language-id = "css";
          command = "vscode-css-languageserver";
          args = ["--stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        taplo-lsp = {
          language-id = "toml";
          command = "taplo";
          args = ["lsp" "stdio"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
        superhtml-lsp = {
          language-id = "html";
          command = "superhtml";
          args = ["lsp"];
          format = {
            preview = true;
          };
          lint = {
            preview = true;
          };
        };
      };

      language = [
        {
          name = "toml";
          auto-format = true;
          language-servers = ["taplo-ls"];
          formatter = {
            command = "taplo";
            args = ["fmt"];
          };
        }
        {
          name = "html";
          auto-format = true;
          language-servers = ["superhtml-lsp"];
          formatter = {
            command = "superhtml";
            args = ["fmt"];
          };
        }
        {
          name = "nim";
          auto-format = true;
          language-servers = ["nimlangserver"];
        }
        {
          name = "ocaml";
          auto-format = true;
          language-servers = ["ocamlPackages.ocaml-lsp"];
        }
        {
          name = "haskell";
          auto-format = true;
          language-servers = ["haskellPackages.lsp"];
        }
        {
          name = "lua";
          auto-format = true;
          language-servers = ["lua-language-server"];
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = ["astro-lsp" "ts-lsp"];
        }
        {
          name = "json";
          auto-format = true;
          language-servers = ["json-lsp"];
        }
        {
          name = "jsonc";
          auto-format = true;
          language-servers = ["json-lsp"];
        }
        {
          name = "json-ld";
          auto-format = true;
          language-servers = ["json-lsp"];
        }
        {
          name = "css";
          auto-format = true;
          language-servers = ["css-lsp"];
        }
        {
          name = "r";
          auto-format = true;
          language-servers = ["rPackages.air"];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = ["ts-lsp"];
        }
        {
          name = "javascript";
          auto-format = true;
          language-servers = ["js-lsp"];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = ["rust-analyzer" "lldb"];
        }
        {
          name = "yaml";
          auto-format = true;
          language-servers = ["yaml-lsp"];
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
          name = "html";
          auto-format = true;
          language-servers = ["superhtml-lsp"];
          formatter = {
            command = "superhtml";
            args = ["lsp"];
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nixd-lsp" "nil-lsp"];
          formatter = {
            command = "alejandra";
          };
        }
        {
          name = "php";
          auto-format = true;
          formatter = ["phpactor"];
          language-servers = ["phpactor-lsp"];
        }
        {
          name = "python";
          language-servers = ["ruff-lsp" "ty-lsp"];
          auto-format = true;
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
        {
          name = "markdown";
          auto-format = true;
          language-servers = ["md"];
        }
        {
          name = "ruby";
          auto-format = true;
          language-servers = ["rubyPackages_3_4.ruby-lsp"];
        }
      ];
    };
    settings = {
      theme = "rose_pine_moon_clear";
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
          character = "┆"; # Some characters that work well: "▏", "┆", "┊", "⸽"
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
      keys = {
        normal = {
          space = {
            B = ":echo %sh{git blame -L %{cursor_line},+1 %{buffer_name}}";
          };
        };
      };
    };
  };
}
