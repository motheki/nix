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
    package = pkgs.git;

    #push.autoSetupRemote = true;
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
      key = "AAAAC3NzaC1lZDI1NTE5AAAAIM4J6BiOFWDuYEh12BfqKDJIyJM+NTGIosm93hxfq/MK";
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        theme = "base16";
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
  programs.gitui = {enable = true;};
}
