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
    "homebrew/cask"
    ];
    brews = [
    "mas"
    "cowsay"
    ];
    masApps = {
    };
    casks = [
      "arc"
      "vmware-fusion"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "crossover"
    ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
  };
}
