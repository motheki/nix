# Desktop software has exactly one owner: Nix packages or Homebrew casks.
{
  den.aspects.features.applications = {
    darwin.homebrew = {
      casks = [
        "steam"
        "vorssaint"
        "chatgpt"
        "macparakeet"
        "orbstack"
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
      # Vesktop owns its settings. programs.discord would also manage the
      # unrelated Discord settings.json in macOS-protected application data.
      home.packages = [pkgs.vesktop];
    };
  };
}
