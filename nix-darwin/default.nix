{ pkgs, ... }: 

{
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };
  nix.package = pkgs.nix;
  programs.zsh.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 4;
  users.users.motheki = {
    name = "motheki";
    home = "/Users/motheki";
  };
}
