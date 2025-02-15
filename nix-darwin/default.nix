{pkgs, ...}: {
  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  system.stateVersion = 5;
  nix.enable = false;
  services.ipfs = {
    enable = true;
    enableGarbageCollection = true;
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
      "Windows App" = 1295203466;
    };
    casks = [
      "betterdisplay"
      "tunnelblick"
      "raycast"
      "cloudflare-warp"
      "linearmouse"
      "obs"
      "CleanShot"
      "ghostty"
      "dolphin"
    ];
    caskArgs = {};
  };
  fonts.packages = with pkgs; [
    ibm-plex
  ];
}
