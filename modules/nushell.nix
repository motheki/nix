{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    plugins = with pkgs; [
      #nushellPlugins.skim
      #nushellPlugins.highlight
      nushellPlugins.query
      nushellPlugins.polars
      nushellPlugins.gstat
    ];
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };
}
