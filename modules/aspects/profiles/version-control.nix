# Git, Jujutsu, SSH, and the supporting repository tools share one profile so
# identity and signing policy remain consistent.
_: {
  den.aspects.profiles.version-control.homeManager = {pkgs, ...}: {
    services.radicle.node = {
      enable = true;
      lazy.enable = true;
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

      gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = true;
          telemetry = "disabled";
        };
      };
      gh-dash.enable = true;

      git = {
        enable = true;
        package = pkgs.gitFull;
        maintenance.enable = true;
        lfs.enable = true;
        ignores = [
          "*.swp"
          ".astro/"
          ".devenv/"
          ".direnv/"
          ".DS_Store"
          ".env"
          ".npmrc"
          ".venv/"
          "dist/"
          "node_modules/"
        ];
        settings = {
          user = {
            name = "trevoropiyo";
            email = "trevoropiyo@trevoropiyo.com";
            signingkey = "~/.ssh/trevoropiyo.pub";
          };
          commit.gpgsign = true;
          format.signoff = true;
          gpg.format = "ssh";
          init.defaultBranch = "main";
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;
          push.autoSetupRemote = true;
          tag.gpgsign = true;
        };
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
            name = "Trevor Opiyo";
            email = "trevoropiyo@trevoropiyo.com";
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
            fetch = "origin";
            push = "origin";
          };
        };
      };
      jjui.enable = true;

      ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*" = {
          IgnoreUnknown = "UseKeychain";
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/trevoropiyo";
          UseKeychain = "yes";
        };
      };
    };
  };
}
