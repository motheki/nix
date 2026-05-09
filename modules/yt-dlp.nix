{ den, ... }:
{
  den.aspects.motheki.homeManager =
    { pkgs, ... }:
    {
      programs.yt-dlp = {
        enable = true;
        package = pkgs.yt-dlp;
        settings = {
          paths = "~/Downloads";
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
