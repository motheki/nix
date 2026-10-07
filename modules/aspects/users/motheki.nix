# Shared identity and signing configuration; host-qualified aspects pick workloads.
{den, ...}: {
  den.aspects.motheki = {
    includes = [
      (den.batteries.user-shell "zsh")
    ];
    homeManager = {pkgs, ...}: let
      email = "trevoropiyo@trevoropiyo.com";
      sshIdentity = "~/.ssh/trevoropiyo";
    in {
      programs = {
        git.settings.user = {
          name = "trevoropiyo";
          inherit email;
          signingkey = "${sshIdentity}.pub";
        };
        jujutsu.settings = {
          user = {
            name = "Trevor Opiyo";
            inherit email;
          };
          signing = {
            key = "${sshIdentity}.pub";
            backends.ssh.allowed-signers = "~/.ssh/allowed_signers";
          };
        };
        ssh = {
          enable = true;
          package = pkgs.openssh_hpn;
          settings."*".IdentityFile = sshIdentity;
        };
        keychain = {
          enable = true;
          keys = ["trevoropiyo"];
        };
      };
    };
  };
}
