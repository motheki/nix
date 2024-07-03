{ pkgs, ...}: 

{
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      extraFlags = ["--verbose"];
      upgrade = false;
    };
    taps = [
    ];
    brews = [
    ];
    masApps = {
      "Numbers" = 409203825;
      "Keynote" = 409183694;
      "MusicSmart" = 1512195368;
      "Mona" = 1659154653;
      "MusicBox" = 1614730313;
      "Noir" = 1592917505;
      "Play" = 1596506190;
      "Testflight" = 899247664;
      "MusicMatch" = 1596146219;
      "DeArrow" = 6451469297;
      "AdGaurd for Safari" = 1440147259;
      "Vinegar" = 1591303229;
      "Spring" = 1508706541;
      "Evo" = 6475402655;
      "SponsorBlock" = 1573461917;
      "Solid Calendar" = 6448245807;
      "Homecoming for Mastodon" = 1666139593;
      "Collections" = 1568395334;
      "WhatsApp" = 310633997;
      "Revita" = 1633036568;
      "Solid Planner" = 6499594033;
      "Formed" = 1661550831;
      "Userscripts-Mac-App" = 1463298887;
      "Infuse" = 1136220934;
      "Sink It for Reddit" = 6449873635;
      "Baking Soda" = 1601151613;
      "Lire" = 1482527526;
      "HacKit" = 1549557075;
      "Solid Notes" = 6448245914;
      "Pages" = 409201541;
      "Developer" = 640199958;
      "Ultra Focus" = 6444367413;
      "iMovie" = 408981434;
      "Hush" = 1544743900;
      "Prime Video" = 545519333;
      "MusicHarbor" = 1440405750;
    };
    casks = [
      "arc"
      "vmware-fusion"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "crossover"
      "obs"
      "steam"
      "cloudflare-warp"
      "tunnelblick@beta"
    ];
    caskArgs = {
      appdir = "~/Applications";
    };
  };
}
