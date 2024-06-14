{ pkgs, ... }: 

{
  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  system.stateVersion = 4;
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };
  nixpkgs.config = {
    hostPlatform = "aarch64-darwin";
    allowBroken = true;
    allowUnfree = true;
  };
  users.users.motheki = {
    name = "motheki";
    home = "/Users/motheki";
  };
}
