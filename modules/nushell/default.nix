{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    plugins = with pkgs; [
      nushellPlugins.query
      nushellPlugins.skim
      nushellPlugins.polars
      nushellPlugins.gstat
      nushellPlugins.highlight
    ];
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
  };
}
