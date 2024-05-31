{ pkgs, ... }: 

{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
      prompt = true;
    };
  };
  programs.gh-dash = {
    enable = true;
  };
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    delta = {
      enable = true;
    };
    lfs = {
      enable = true;
    };
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
  programs.gitui = {
    enable = true;
  };
}
