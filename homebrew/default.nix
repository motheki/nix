{ pkgs, ...}: 

{
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = ["--verbose"];
      upgrade = true;
    };
    taps = [
    ];
    brews = [
    ];
    casks = [
      "arc"
      "vmware-fusion"
      "discord@canary"
      "raycast"
      "betterdisplay"
    ];
  };
}
