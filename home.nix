# home.nix
{ config, pkgs, ... }:

{
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {};
    shellAliases = {
      rg = "batgrep";
      cat = "prettybat";
      speedtest = "networkQuality -v";
      man = "batman";
      ls = "lla -G -T";
      rm = "rip";
      find = "fd";
      du = "dust";
      sed = "sd";
    };
    packages = with pkgs; [
      rm-improved
      dust
      jless
      webtorrent_desktop
      vivid
      onefetch
      duf
      tarlz
      glow
      fd
      lla
      xan
      ox
      sd
      curlFull
      pueue
      glab
      nmap
      tree
      rustscan
      fastfetch
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
