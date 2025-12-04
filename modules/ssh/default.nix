{pkgs, ...}: {
	services.ssh-agent = {
		enable = true;
	};
  programs.ssh = {
    enable = true;
    package = pkgs.openssh_hpn;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
      addKeysToAgent = "yes";
      compression = true;
      hashKnownHosts = true;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "yes";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "yes";
    };
    #extraConfig = "UseKeychain yes";
  };
  programs.keychain = {
    enable = true;
    keys = ["trevoropiyo"];
  };
}
