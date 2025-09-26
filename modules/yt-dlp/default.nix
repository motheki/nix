{...}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      paths = "/Volumes/mothekis_drive/Videos/Youtube/";
      embed-thumbnail = true;
      embed-metadata = true;
      sponsorblock-remove = "selfpromo,interaction,sponsor";
      progress = true;
      quiet = true;
      check-all-formats = true;
      output = "%(title)s.%(ext)s";
      format = "bv+ba/bv*+ba/b";
      video-multistreams = true;
      audio-multistreams = true;
    };
  };
}
