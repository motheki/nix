{pkgs, ...}: {
  programs.home-manager = {enable = true;};
  home = {
    stateVersion = "25.05";
    sessionVariables = {};
    shellAliases = {
      rg = "batgrep";
      cat = "prettybat";
      man = "batman";
      cp = "xcp";
      rm = "rip";
      find = "fd";
      du = "dust";
      sed = "sd";
      nupdate = "sudo nix --extra-experimental-features 'nix-command flakes' run 'nix-darwin/master'#darwin-rebuild -- switch --flake ~/Repos/nix  --fallback";
    };
    file = {};
    sessionPath = ["/opt/homebrew/bin" "/opt/homebrew/Cellar"];
    packages = with pkgs; [
      xcp
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
      iina
      scc
      ffmpeg-full
      helix-gpt
      chafa
      #lsr
      #ghostty-bin
    ];
  };
}
