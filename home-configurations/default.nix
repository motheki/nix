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
      vivid
      duf
      tarlz
      glow
      fd
      treefmt2
      sd
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
      discord-canary
      ffmpeg-full
      helix-gpt
      ruffle
      mold
      chafa
      #dolphin-emu
      #ghostty
    ];
  };
}
