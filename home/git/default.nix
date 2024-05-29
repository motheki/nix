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
      key = "AAAAC3NzaC1lZDI1NTE5AAAAIM4J6BiOFWDuYEh12BfqKDJIyJM+NTGIosm93hxfq/MK trevoropiyo@trevoropiyo.com";
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
