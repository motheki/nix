{...}: {
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = true;
      };
    };
    #glab = {
    #  enable = true;
    #};
    gh-dash = {enable = true;};
    lazygit = {enable = true;};
    git = {
      enable = true;
      ignores = [
        "*~"
        "*.swp"
        "node_modules"
        "dist"
        ".astro/*"
        ".env"
        ".envrc"
        ".direnv"
        ".devenv"
        ".DS_Store"
        ".npmrc"
      ];
      settings = {
        gpg = {
          format = "ssh";
        };
        commit = {
          gpgsign = true;
        };
        tag = {
          gpgsign = true;
        };
        user = {
          signingkey = "~/.ssh/trevoropiyo.pub";
        };
        format = {
          signoff = true;
        };
        user = {
          name = "trevoropiyo";
          email = "trevoropiyo@trevoropiyo.com";
        };
        push = {
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        merge = {
          conflictStyle = "zdiff3";
        };
      };
      lfs = {enable = true;};
    };
    git-cliff = {
      enable = true;
      settings = {
        header = "Change Log";
        trim = true;
      };
    };
  };
}
