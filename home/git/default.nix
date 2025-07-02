{pkgs, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = true;
    };
  };
  programs.gh-dash = {enable = true;};
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    maintenance = {
      enable = true;
    };
    ignores = [
      "*~"
      "*.swp"
      "node_modules"
      "dist"
      ".astro/*"
      ".wrangler/*"
      ".envrc"
      ".env"
      "bun.lock"
      "bun.lockb"
      ".DS_Store"
      ".npmrc"
      ".direnv/*"
      ".pre-commit-config.yaml"
    ];
    extraConfig = {
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
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        theme = "Github";
        diff-so-fancy = true;
      };
    };
    lfs = {enable = true;};
    userName = "trevoropiyo";
    userEmail = "trevoropiyo@trevoropiyo.com";
  };
  programs.git-cliff = {
    enable = true;
    settings = {
      header = "Change Log";
      trim = true;
    };
  };
  programs.gitui = {
    enable = true;
  };
}
