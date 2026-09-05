# Full codec/document functionality remains an independently selectable feature.
{
  den.aspects.features.media.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [ffmpeg_9-full imagemagickBig pdf-cli];
    programs.yt-dlp = {
      enable = true;
      settings = {
        ffmpeg-location = "${pkgs.ffmpeg_9-full}/bin/ffmpeg";
        embed-thumbnail = true;
        embed-metadata = true;
        sponsorblock-remove = "selfpromo,interaction,sponsor";
        progress = true;
        quiet = true;
        check-all-formats = true;
        output = "%(title)s.%(ext)s";
      };
    };
  };
}
