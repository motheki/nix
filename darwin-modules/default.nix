{
  pkgs,
  inputs,
  ezModules,
  ...
}: {
  security.pam.services.sudo_local.touchIdAuth = true;
  programs.zsh.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
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
      #"Numbers" = 409203825;
      #"Keynote" = 409183694;
      #"MusicBox" = 1614730313;
      #"Flighty" = 1358823008;
      #"Play" = 1596506190;
      #"Testflight" = 899247664;
      #"MusicMatch" = 1596146219;
      #"Xcode" = 497799835;
      #"SponsorBlock" = 1573461917;
      #"WhatsApp" = 310633997;
      #"Infuse" = 1136220934;
      #"TestFlight" = 899247664;
      #"Pages" = 409201541;
      #"Developer" = 640199958;
      #"Prime Video" = 545519333;
      #"MusicHarbor" = 1440405750;
    };
    casks = [
      "betterdisplay"
      #"tunnelblick"
      "raycast"
      "cloudflare-warp"
      "linearmouse"
      "Steam"
      "obs"
      "CleanShot"
      "zen-browser"
      "brave-browser@nightly"
      "ghostty"
      "dolphin"
    ];
    caskArgs = {};
  };
}
