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
      "Flighty" = 1358823008;
      "Play" = 1596506190;
      "Testflight" = 899247664;
      "Wipr" = 1320666476;
      "Microsoft Remote Desktop" = 1295203466;
      "MusicMatch" = 1596146219;
      "DeArrow" = 6451469297;
      "Vinegar" = 1591303229;
      "Spring" = 1508706541;
      "SponsorBlock" = 1573461917;
      "Homecoming for Mastodon" = 1666139593;
      "Collections" = 1568395334;
      "WhatsApp" = 310633997;
      "Revita" = 1633036568;
      "Userscripts-Mac-App" = 1463298887;
      "Infuse" = 1136220934;
      "Sink It for Reddit" = 6449873635;
      "Baking Soda" = 1601151613;
      "HacKit" = 1549557075;
      "Pages" = 409201541;
      "Developer" = 640199958;
      "iMovie" = 408981434;
      "Hush" = 1544743900;
      "Prime Video" = 545519333;
      "MusicHarbor" = 1440405750;
    };
    casks = [
      "arc"
      "discord@canary"
      "raycast"
      "betterdisplay"
      "crossover"
      "obs"
      "steam"
      "cloudflare-warp"
      "tunnelblick"
    ];
    caskArgs = {
    };
  };
}
