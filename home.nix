{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {};
    shellAliases = {
      rg = "batgrep";
      speedtest = "networkQuality -v";
      ls = "lla -G -T";
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run home-manager/master  -- switch  --flake ~/Repos/nix --show-trace";
    };
    packages = with pkgs; [
      brewCasks.thebrowsercompany-dia
      brewCasks."discord@canary"
      brewCasks.ghostty
      rm-improved
      dust
      jless
      webtorrent_desktop
      vivid
      onefetch
      duf
      tarlz
      glow
      lla
      xan
      sd
      curlFull
      pueue
      nmap
      tree
      rustscan
      onefetch
      hyperfine
      halp
      scc
      ffmpeg-full
      yq-go
      chafa
    ];
  };
  imports = [
    ./modules
  ];
}
