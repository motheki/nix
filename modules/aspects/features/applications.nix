# Desktop software has exactly one owner: Nix packages or Homebrew casks.
{
  den.aspects.features.applications = {
    darwin.homebrew = {
      casks = [
        "steam"
        "vorssaint"
        "chatgpt"
        "macparakeet"
        "zen"
        "expo-orbit"
        "paper-design"
        "helium-browser"
        "linear"
        "t3-code@nightly"
        "codex"
      ];
      brews = [
        "fx-agent"
        "hunk"
      ];
    };
    homeManager = {pkgs, ...}: {
      targets.darwin.copyApps = {
        enable = true;
        directory = "Applications/home-manager";
      };
      programs = {
        discord = {
          enable = true;
          package = pkgs.vesktop;
        };
      };
    };
  };
}
