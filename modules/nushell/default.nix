{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    plugins = [
      pkgs.nushellPlugins.net
      pkgs.nushellPlugins.query
      pkgs.nushellPlugins.skim
      pkgs.nushellPlugins.polars
      pkgs.nushellPlugins.highlight
    ];
    settings = {
      show_banner = false;
    };
  };
}
