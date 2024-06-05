{
  targets.darwin  = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true; 
      };
      "com.apple.dock" = {
        autohide = true; 
        launchanim = false;
        magnification = false; 
        mineffect = "Scale"; 
        minimize-to-application = false; 
        orientation = "bottom"; 
        windowtabbing = true;
        show-process-indicators = false;
        show-recents = false;
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
