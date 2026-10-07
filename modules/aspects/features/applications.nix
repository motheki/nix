# Desktop software has exactly one owner: Nix packages or Homebrew casks.
{
  den.aspects.features.applications = {
    darwin.homebrew.casks = [
      "steam"
      "thebrowsercompany-dia"
      "vorssaint"
      "claude"
      "chatgpt"
    ];
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        iina
        orbstack
        webtorrent_desktop
      ];
      targets.darwin.copyApps = {
        enable = true;
        directory = "Applications/home-manager";
      };
      programs = {
        ghostty = {
          enable = true;
          package = pkgs.ghostty-bin;
          settings = {
            theme = "light: Gruvbox Material Light, dark: Gruvbox Material Dark";
            font-size = 16;
            font-family = "CommitMonoMotheki";
            cursor-style = "bar";
            background-opacity = 0.85;
            background-blur = true;
            window-height = 40;
            window-width = 120;
            window-padding-x = 8;
            window-padding-y = 4;
            window-inherit-working-directory = true;
            tab-inherit-working-directory = true;
            split-inherit-working-directory = true;
            macos-titlebar-style = "transparent";
            auto-update-channel = "tip";
          };
        };
        vesktop = {
          enable = true;
          vencord.useSystem = true;
        };
      };
    };
  };
}
