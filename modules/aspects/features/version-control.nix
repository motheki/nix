# Shared VCS behavior and signing policy. Personal identities live in users/.
_: {
  den.aspects.features.version-control.homeManager = {pkgs, ...}: {
    programs = {
      # The upstream node service is systemd-only. Keep the CLI available,
      # without pretending it starts a macOS background service.
      radicle.enable = true;
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
          core.pager = "hunk pager";
          diff.tool = "hunk";
          difftool = {
            hunk.cmd = ''hunk difftool "$LOCAL" "$REMOTE" "$MERGED"'';
            prompt = false;
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
          ui = {
            pager = ["hunk" "pager"];
            diff-formatter = ":git";
            editor = "nvim";
            default-command = "log";
          };
          signing = {
            behavior = "drop";
            backend = "ssh";
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
          UseKeychain = "yes";
        };
      };
    };
  };
}
