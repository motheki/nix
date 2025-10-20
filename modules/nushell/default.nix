{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    plugins = [
      pkgs.nushellPlugins.query
      pkgs.nushellPlugins.skim
      pkgs.nushellPlugins.polars
      pkgs.nushellPlugins.gstat
      #pkgs.nushellPlugins.highlight
    ];
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };
}
