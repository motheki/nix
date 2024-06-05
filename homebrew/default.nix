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
    "Solid Calendar" = 6448245807;
    "Homecoming for Mastodon" = 1666139593;
    "Grammar Fix" = 1457909769;
    "WhatsApp" = 310633997;
    "MusicSmart" = 1512195368;
    "Mona" = 1659154653;
    "MusicBox" = 1614730313;
    "Solid Planner" = 6499594033;
    "Noir" = 1592917505;
    "Formed" = 1661550831;
    "Infuse" = 1136220934;
    "Baking Soda" = 1601151613;
    "Play" = 1596506190;
    "Solid Notes" = 6448245914;
    "Testflight" = 899247664;
    "MusicMatch" = 1596146219;
    "DeArrow" = 6451469297;
    "AdGaurd for Safari" = 1440147259;
    "Ultra Focus" = 6444367413;
    "Vinegar" = 1591303229;
    "Spring" = 1508706541;
    "Evo" = 6475402655;
    "MusicHarbor" = 1440405750;
    "SponsorBlock" = 1573461917;
    };
    casks = [
      "arc"
      "vmware-fusion"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "crossover"
      "zoom"
    ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
  };
}
