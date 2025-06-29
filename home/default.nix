{pkgs, ...}: {
  imports = [
    ./home-manager
    ./shell
    ./ssh
    ./git
    ./helix
  ];
}
