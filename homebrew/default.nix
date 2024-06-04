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
    "mas"
    ];
    masApps = {
    "Pages" = 409201541;
    "Numbers" = 409203825;
    "Keynote" = 409183694;
    "Solid Planner" = -2090340559;
    "Evo - The Everything App" = -2114531937;
    "Solid Calendar" = -2141688785;

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
