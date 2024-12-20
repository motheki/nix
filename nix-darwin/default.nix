{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  nix.useDaemon = true;
  system.stateVersion = 4;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      warn-dirty = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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
    taps = [];
    brews = [];
    masApps = {
      "Numbers" = 409203825;
      "Keynote" = 409183694;
      "MusicSmart" = 1512195368;
      "Mona" = 1659154653;
      "imgpls" = 6639617400;
      "MusicBox" = 1614730313;
      "Noir" = 1592917505;
      "Flighty" = 1358823008;
      "Play" = 1596506190;
      "Testflight" = 899247664;
      "MusicMatch" = 1596146219;
      "DeArrow" = 6451469297;
      "Vinegar" = 1591303229;
      "Spring" = 1508706541;
      "Wipr" = 1662217862;
      "Xcode" = 497799835;
      "SponsorBlock" = 1573461917;
      "Homecoming for Mastodon" = 1666139593;
      "WhatsApp" = 310633997;
      "Infuse" = 1136220934;
      "Sink It for Reddit" = 6449873635;
      "Userscripts-Mac-App" = 1463298887;
      "TestFlight" = 899247664;
      "Pages" = 409201541;
      "Developer" = 640199958;
      "Prime Video" = 545519333;
      "MusicHarbor" = 1440405750;
    };
    casks = [
      "arc"
      "discord@canary"
      "betterdisplay"
      "tunnelblick"
      "raycast"
      "cloudflare-warp"
      "linearmouse"
      "obs"
      "steam"
      "CleanShot"
    ];
    caskArgs = {};
  };
  fonts.packages = with pkgs; [
    ibm-plex
  ];
}
