# Desktop software has exactly one owner: Nix packages or Homebrew casks.
{
  den.aspects.features.applications = {
    darwin.homebrew.casks = [
      "daisydisk"
      "chatgpt"
      "steam"
      "thebrowsercompany-dia"
      "raycast"
      "betterdisplay"
      "zen"
      "paper-design"
      "orion"
      "cleanshot"
      "linear"
      "obs"
      "mos"
    ];
    homeManager = {pkgs, ...}: {
      targets.darwin.copyApps = {
        enable = true;
        directory = "Applications/home-manager";
      };
      home.packages = with pkgs; [webtorrent_desktop orbstack iina];
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
        discord.enable = true;
      };
    };
  };
}
