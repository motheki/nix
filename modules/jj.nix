{ den, ... }:
{
  den.aspects.motheki.homeManager = {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "trevoropiyo@trevoropiyo.com";
        name = "Trevor Opiyo";
      };
      ui = {
        pager = ":git";
        diff-formatter = "delta";
        editor = "nvim";
        default-command = "log";
      };
      signing = {
        behavior = "drop";
        backend = "ssh";
        key = "~/.ssh/trevoropiyo.pub";
        backends = {
          ssh = {
            allowed-signers = "~/.ssh/allowed_signers";
          };
        };
      };
      remotes = {
        origin = {
          auto-track-bookmarks = "*";
        };
      };
      fsmonitor = {
        backend = "watchman";
        watchman = {
          register-snapshot-trigger = true;
        };
      };
      snapshot = {
        auto-update-stale = true;
      };
      git = {
        sign-on-push = true;
        fetch = ["origin"];
        push = ["origin"];
      };
    };
  };
  programs.jjui = {
    enable = true;
  };
  };
}
