{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- home switch -u -v -t --fallback --refresh --impure --accept-flake-config -I ~/Repos/nix  ~/Repos/nix";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean all";
    };
    packages = with pkgs; [
      brewCasks."legcord"
      rm-improved
      iina
      webtorrent_desktop
      ffmpeg-full
    ];
  };
  imports = [
    ./modules
  ];
}
