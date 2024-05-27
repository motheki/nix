{
  targets.darwin  = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true; 
      };
      "com.apple.dock" = {
        autohide = true; 
        autohide-delay = 0; 
        autohide-time-modifier = 0; 
        launchanim = true;
        magnification = true; 
        mineffect = "scale"; 
        minimize-to-application = false; 
        orientation = "bottom"; 
        windowtabbing = true;
        show-process-indicators = false;
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
        FXEnableExtensionChangeWarning = false; 
        FXEnableRemoveFromICloudDriveWarning = false; 
        ShowPathbar = true; 
        ShowStatusBar = true; 
        _FXShowPosixPathInTitle = true; 
        _FXSortFoldersFirst = true; 
      };
    };
  };
}
