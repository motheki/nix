{pkgs, ...}: {
  programs.streamlink = {
    enable = true;
    settings = {
      player = "~/.nix-profile/bin/iina";
      player-continuous-http = true;
      stream-segment-threads = 6;
      twitch-supported-codecs = "h264,h265,av1";
      quiet = true;
      player-fifo = true;
    };
  };
}
