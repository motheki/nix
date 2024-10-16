{
  targets.darwin = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {BatteryShowPercentage = false;};
      "com.apple.dock" = {
        autohide = true;
        autohide-time-modifier = 0.4;
        # autohide-delay = 0.2;
        # expose-animation-duration = 0.2;
        # springboard-show-duration = 0.1;
        # springboard-hide-duration = 0.1;
        # springboard-page-duration = 0.1;
        launchanim = true;
        magnification = true;
        mineffect = "suck";
        minimize-to-application = true;
        orientation = "bottom";
        windowtabbing = true;
        show-process-indicators = true;
        show-recents = true;
        pinning = "start";
        showAppExposeGestureEnabled = true;
        showDesktopGestureEnabled = true;
        showLaunchpadGestureEnabled = true;
        showMissionControlGestureEnabled = true;
        showSpacesGestureEnabled = true;
        tilesize = 48;
      };
      "com.apple.finder" = {
        AppleShowAllFiles = true;
        DisableAllAnimations = false;
        FXPreferredViewStyle = "clmv";
        FXEnableExtensionChangeWarning = false;
        FXEnableRemoveFromICloudDriveWarning = false;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      "com.apple.mouse" = {linear = true;};
    };
  };
}
