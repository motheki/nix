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
      "vmwarefusion@preview"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "betterdiscord-installer"
    ];
  };
}
