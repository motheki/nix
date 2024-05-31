{ pkgs, ...}: 

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
    };
    taps = [
    ];
    brews = [
    ];
    casks = [
      "arc"
      "vmwarefusion"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "betterdiscord-installer"
    ];
  };
}
