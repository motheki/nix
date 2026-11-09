# Shared identity and signing configuration; host-qualified aspects pick workloads.
{den, ...}: {
  den.aspects.motheki = {
    includes = [
      (den.batteries.user-shell "zsh")
    ];
    homeManager = {
      config,
      lib,
      pkgs,
      ...
    }: let
      email = "trevoropiyo@trevoropiyo.com";
      sshIdentity = "~/.ssh/trevoropiyo";
      keychain = config.programs.keychain;
      keychainArgs = lib.escapeShellArgs (keychain.extraFlags ++ keychain.keys);
      sshAdd = "${config.programs.ssh.package}/bin/ssh-add";
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
          enableZshIntegration = false;
        };
        # The stock integration invokes keychain unconditionally in every shell.
        zsh.initContent = lib.mkIf keychain.enable ''
          # Explicitly reload keys after locking/clearing an otherwise live agent.
          ssh-unlock() {
            local agent_env
            agent_env="$(SHELL=zsh ${keychain.package}/bin/keychain --eval ${keychainArgs})" || return
            eval "$agent_env"
          }

          # Prefer an inherited agent (including SSH forwarding), then the cache.
          # Probe the agent, not just its socket/PID: both can survive a dead agent.
          # Run keychain only on first use or when the agent needs recovery/unlocking.
          () {
            ${sshAdd} -l >/dev/null 2>&1 && return
            local agent_file="$HOME/.keychain/$HOST-sh"
            if [[ -r "$agent_file" ]]; then
              source "$agent_file"
              ${sshAdd} -l >/dev/null 2>&1 && return
            fi
            ssh-unlock
          }
        '';
      };
    };
  };
}
