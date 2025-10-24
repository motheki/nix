{...}: {
  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = true;
      };
    };
    gh-dash = {enable = true;};
    #gitui = {enable = true;};
    git = {
      enable = true;
      ignores = [
        "*~"
        "*.swp"
        "node_modules"
        "dist"
        ".astro/*"
        ".env"
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
