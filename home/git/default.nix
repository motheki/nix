{pkgs, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = true;
    };
  };
  #programs.gh-dash = {enable = true;};
  programs.git = {
    enable = true;
    package = pkgs.git;

    #push.autoSetupRemote
    ignores = [
      "*~"
      "*.swp"
      "node_modules"
      "dist"
      ".astro/*"
      ".wrangler/*"
      ".envrc"
      ".env"
      ".npmrc"
      ".direnv/*"
    ];
    signing = {
      key = "~/.ssh/trevoropiyo";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        theme = "Monokai Extended";
      };
    };
    lfs = {enable = true;};
    userName = "motheki";
    userEmail = "motheki@icloud.com";
  };
  programs.git-cliff = {
    enable = true;
    settings = {
      header = "Change Log";
      trim = true;
    };
  };
  programs.gitui = {enable = true;};
}
