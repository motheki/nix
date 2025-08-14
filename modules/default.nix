{pkgs, ...}: {
  imports = [
    ./shell
    ./ssh
    ./git
    ./helix
    ./ghostty
  ];
}
