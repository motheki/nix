_: {
  den.aspects.profiles.vcs.homeManager = {pkgs, ...}: {
    services = {
      ssh-agent.enable = true;
      radicle.node = {
        enable = true;
        lazy.enable = true;
      };
    };

    programs = {
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          side-by-side = true;
          line-numbers = true;
          theme = "ansi";
        };
      };
      radicle = {
        enable = true;
      };

      gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = true;
          telemetry = "disabled";
        };
      };

      gh-dash.enable = true;
      lazygit.enable = false;

      git = {
        enable = true;
        package = pkgs.gitFull;
        maintenance.enable = true;
        ignores = [
          "*.swp"
          "node_modules/"
          "dist/"
          ".astro/"
          ".env"
          ".direnv/"
          ".devenv/"
          ".DS_Store"
          ".npmrc"
          ".venv/"
        ];
        settings = {
          gpg.format = "ssh";
          commit.gpgsign = true;
          tag.gpgsign = true;
          user = {
            signingkey = "~/.ssh/trevoropiyo.pub";
            name = "trevoropiyo";
            email = "trevoropiyo@trevoropiyo.com";
          };
          format.signoff = true;
          push.autoSetupRemote = true;
          pull.rebase = true;
          init.defaultBranch = "main";
          merge.conflictStyle = "zdiff3";
        };
        lfs.enable = true;
      };

      git-cliff = {
        enable = true;
        settings = {
          header = "Change Log";
          trim = true;
        };
      };

      jujutsu = {
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
            default-command = "log";
          };
          signing = {
            behavior = "drop";
            backend = "ssh";
            key = "~/.ssh/trevoropiyo.pub";
            backends.ssh.allowed-signers = "~/.ssh/allowed_signers";
          };
          remotes.origin.auto-track-bookmarks = "*";
          fsmonitor = {
            backend = "watchman";
            watchman.register-snapshot-trigger = true;
          };
          snapshot.auto-update-stale = true;
          git = {
            colocate = true;
            sign-on-push = true;
            track-default-bookmark-on-clone = true;
            abandon-unreachable-commits = true;
            fetch = ["origin"];
            push = ["origin"];
          };
        };
      };

      jjui.enable = true;

      keychain = {
        enable = true;
        keys = ["trevoropiyo"];
      };

      ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {};
      };
    };
  };
}
