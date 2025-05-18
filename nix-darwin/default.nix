{pkgs, ...}: {
  security.pam.services.sudo_local.touchIdAuth = true;
  programs.zsh.enable = true;
  system.stateVersion = 6;
  system.primaryUser = "motheki";
  nix = {
    enable = true;
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
    };
    settings = {
      experimental-features = "nix-command flakes";
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
      brewfile = false;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = ["--verbose"];
      upgrade = true;
    };
    taps = [];
    brews = [];
    caskArgs = {
      appdir = "~/Applications";
    };
    masApps = {
      "Numbers" = 409203825;
      "Keynote" = 409183694;
      "MusicBox" = 1614730313;
      "Flighty" = 1358823008;
      "Play" = 1596506190;
      "Testflight" = 899247664;
      "MusicMatch" = 1596146219;
      "Xcode" = 497799835;
      "SponsorBlock" = 1573461917;
      "WhatsApp" = 310633997;
      "Infuse" = 1136220934;
      "TestFlight" = 899247664;
      "Pages" = 409201541;
      "Developer" = 640199958;
      "Prime Video" = 545519333;
      "MusicHarbor" = 1440405750;
    };
    casks = [
      "betterdisplay"
      #"tunnelblick"
      "raycast"
      "crossover"
      "cloudflare-warp"
      "linearmouse"
      "Steam"
      "obs"
      "CleanShot"
      "zen"
      "adguard-vpn"
      "brave-browser"
      "ghostty"
      "legcord"
      "dolphin"
    ];
    caskArgs = {};
  };
  fonts.packages = with pkgs; [
    anonymousPro
    libre-bodoni
    comfortaa
    lexend
    raleway
    ibm-plex
    jetbrains-mono
    nerd-fonts.commit-mono
  ];
}
