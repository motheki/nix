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
    signing = {
      key = "/Users/motheki/.ssh/trevoropiyo.pub";
      signByDefault = true;
    };
    userEmail = "trevoropiyo@trevoropiyo.com";   
    userName = "Trevor Opiyo";
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
