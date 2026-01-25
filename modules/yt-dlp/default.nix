{...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      paths = "/Volumes/mothekis_drive/videos/youtube/";
      embed-thumbnail = true;
      embed-metadata = true;
      sponsorblock-remove = "selfpromo,interaction,sponsor";
      progress = true;
      quiet = true;
      check-all-formats = true;
      output = "%(title)s.%(ext)s";
    };
  };
}
