{pkgs, ...}: {
  imports = [
    ./shell
    ./ssh
    ./git
    ./ghostty
    ./helix
  ];
}
