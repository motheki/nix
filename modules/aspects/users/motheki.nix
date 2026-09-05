# Identity, personal paths and capability selection; implementations are reusable.
{den, ...}: {
  den.aspects.motheki = {
    includes = [
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
      den.aspects.profiles.workstation
      den.aspects.profiles.editor-full
      den.aspects.profiles.mobile-developer
      # Optional: den.aspects.features.fonts-extra / editor-extras.
    ];
    homeManager = {config, ...}: let
      repo = "${config.home.homeDirectory}/Repos/personal/nix";
      email = "trevoropiyo@trevoropiyo.com";
      sshIdentity = "~/.ssh/trevoropiyo";
    in {
      programs.git.settings.user = {
        name = "trevoropiyo";
        inherit email;
        signingkey = "${sshIdentity}.pub";
      };
      programs.jujutsu.settings = {
        user = {
          name = "Trevor Opiyo";
          inherit email;
        };
        signing = {
          key = "${sshIdentity}.pub";
          backends.ssh.allowed-signers = "~/.ssh/allowed_signers";
        };
      };
      programs.ssh.settings."*".IdentityFile = sshIdentity;
      programs.nh.darwinFlake = repo;
      home.shellAliases = {
        rebuild = "nix run ${repo}#switch --";
        # A preview by default, never the old retain-one-generation clean-all.
        clean = "nix run ${repo}#maintenance --";
      };
      programs.yt-dlp.settings.paths = "/Volumes/mothekis_drive/videos/youtube";
    };
    darwin.homebrew.brews = ["dmtrkovalenko/fff/fff-mcp"];
  };
}
