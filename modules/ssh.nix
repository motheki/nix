{ pkgs, ... }:
{
  services.ssh-agent = {
    enable = true;
  };
  programs.keychain = {
    enable = true;
    keys = [ "trevoropiyo" ];
  };
  programs.ssh = {
    enable = true;
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
    extraConfig = "IgnoreUnknown UseKeychain\nUseKeychain yes";
  };
}
