{
  targets.darwin  = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true; 
      };
      "com.apple.dock" = {
        autohide = true; 
        autohide-time-modifier = 0; 
        autohide-delay = 0; 
        expose-animation-duration = 0; 
        springboard-show-duration = 0; 
        springboard-hide-duration = 0; 
        springboard-page-duration = 0; 
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
	DisableAlAnimations = true;
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
