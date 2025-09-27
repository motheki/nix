{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh' -- home switch -u -v -t --fallback --refresh --impure --accept-flake-config ~/Repos/nix";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh' -- clean all";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager'  -- switch  --flake ~/Repos/nix --show-trace";
    };
    packages = with pkgs; [
      brewCasks."legcord"
      rm-improved
      iina
      webtorrent_desktop
      ffmpeg_8-full
    ];
  };
  imports = [
    ./modules
  ];
}
