_:

{
  services = {
    radicle = {
      node = {
        enable = true;
        lazy = {
          enable = true;
        };
      };
    };
  };
  #programs = {
  #  radicle = {
  #    enable = true;
  #    cli = {
  #      package = pkgs.radicle-node
  #    };
  #    uri = {
  #      rad = {
  #        browser = {
  #          enable = true;
  #        };
  #      };
  #    };
  #  };
  #};
}
