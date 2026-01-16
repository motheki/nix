{ ... }:
{
  programs.radicle = {
    #enable = true;
    #uri = {
    #  web-rad = {
    #    enable = true;
    #  };
    #  rad = {
    #    browser = {
    #      enable = true;
    #    };
    #  };
    #};
  };
  services.radicle = {
    node = {
      enable = true;
      lazy = {
        enable = true;
      };
    };
  };
}
