_: {
  den.aspects.profiles.apps.homeManager = {pkgs, ...}: {
    programs = {
      ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          theme = "light: Rose Pine Dawn, dark: Rose Pine Moon";
          font-size = 16;
          font-family = "CommitMonoMotheki";
          cursor-style = "bar";
          background-opacity = 0.85;
          background-blur = true;
          window-height = 53;
          window-width = 160;
          window-padding-x = 8;
          window-padding-y = 4;
          window-inherit-working-directory = false;
          tab-inherit-working-directory = false;
          split-inherit-working-directory = false;
          macos-titlebar-style = "transparent";
          auto-update = "off";
        };
      };

      yt-dlp = {
        enable = true;
        settings = {
          paths = "/Volumes/mothekis_drive/videos/youtube";
          ffmpeg-location = "/etc/profiles/per-user/motheki/bin/ffmpeg";
          embed-thumbnail = true;
          embed-metadata = true;
          sponsorblock-remove = "selfpromo,interaction,sponsor";
          progress = true;
          quiet = true;
          check-all-formats = true;
          output = "%(title)s.%(ext)s";
        };
      };

      discord.enable = true;
    };
  };
}
