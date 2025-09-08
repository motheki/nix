{pkgs, ...}: {
  imports = [
    ./shell
    ./ssh
    ./btop
    ./git
    ./ghostty
    ./helix
  ];
}
