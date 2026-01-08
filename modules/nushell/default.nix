{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    plugins = with pkgs; [
      nushellPlugins.query
      #nushellPlugins.skim
      #nushellPlugins.highlight
      nushellPlugins.polars
      nushellPlugins.gstat
    ];
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };
}
