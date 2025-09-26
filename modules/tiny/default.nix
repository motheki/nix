{...}: {
  programs.nh = {
    enable = true;
    #homeFlake = "~/Repos/nix";
    clean = {
      enable = true;
    };
  };
}
