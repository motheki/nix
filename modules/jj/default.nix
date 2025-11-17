{...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "trevoropiyo@trevoropiyo.com";
        name = "Trevor Opiyo";
      };
      ui = {
        pager = "delta";
        diff-formatter = ":git";
        editor = "nvim";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/trevoropiyo.pub";
        backends = {
          ssh = {
            allowed-signers = "~/.ssh/allowed_signers";
          };
        };
      };
      git = {
        sign-on-push = true;
        fetch = ["upstream" "origin"];
        push = "origin";
      };
    };
  };
  programs.jjui = {
    enable = true;
  };
}
