{pkgs, ...}: {
  security.pam.services.sudo_local.touchIdAuth = true;
  programs.zsh.enable = true;
  system.stateVersion = 6;
  system.primaryUser = "motheki";
  nix = {
    enable = true;
    package = pkgs.nixVersions.git;
    linux-builder = {
      enable = true;
      ephemeral = true;
      supportedFeatures = [
        "big-parallel"
      ];
    };
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
    };
    settings = {
      extra-experimental-features = "nix-command flakes";
      accept-flake-config = true;
      allow-dirty = true;
      always-allow-substitutes = true;
      fallback = true;
      max-jobs = "auto";
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
    taps = [
      "psharma04/dorion"
    ];
    brews = [];
    caskArgs = {
      appdir = "/Applications";
    };
    masApps = {
      "Numbers" = 409203825;
      "Keynote" = 409183694;
      "MusicBox" = 1614730313;
      "Flighty" = 1358823008;
      "Play" = 1596506190;
      "Testflight" = 899247664;
      "MusicMatch" = 1596146219;
      "AdGuard for Safari" = 1440147259;
      "Boom3D Netflix Extension" = 6445882848;
      "Lucky" = 6627338771;
      "Refined GitHub" = 1519867270;
      "Noir" = 1592917505;
      "Sink It" = 6449873635;
      "imgpls" = 6639617400;
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
      "raycast"
      "linearmouse@beta"
      "obs@beta"
      "brave-browser@nightly"
      "CleanShot"
      "adguard-vpn@nightly"
      "dorion"
      "ghostty@tip"
      "openemu"
      "dolphin@dev"
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
