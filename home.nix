{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run home-manager/master  -- switch  --flake ~/Repos/nix --show-trace";
    };
    packages = with pkgs; [
      brewCasks."legcord"
      brewCasks."thebrowsercompany-dia"
      brewCasks."betterdisplay"
      rm-improved
      iina
      duf
      dust
      webtorrent_desktop
      glow
      sd
      skim
      curlFull
      hyperfine
      scc
      ffmpeg-full
    ];
  };
  imports = [
    ./modules
  ];
}
