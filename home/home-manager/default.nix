{pkgs, ...}: {
  programs.home-manager = {enable = true;};
  home = {
    stateVersion = "25.05";
    sessionVariables = {};
    shellAliases = {
      rg = "batgrep";
      cat = "prettybat";
      man = "batman";
    };
    file = {};
    sessionPath = ["/opt/homebrew/bin" "/opt/homebrew/Cellar/"];
    packages = with pkgs; [
      xcp
      rm-improved
      dust
      jless
      webtorrent_desktop
      #nodePackages_latest.webtorrent-cli
      niv
      vivid
      duf
      tarlz
      glow
      fd
      treefmt2
      sd
      zoom-us
      nodePackages_latest.prettier
      curlFull
      pueue
      glab
      nmap
      tree
      rustscan
      fastfetch
      hyperfine
      gitoxide
      iina
      scc
      ffmpeg-full
      vesktop
      helix-gpt
      ruffle
      #dolphin-emu
      #ghostty
    ];
  };
}
