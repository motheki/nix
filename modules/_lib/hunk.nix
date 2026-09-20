# Hunk has no Home Manager module; generate its XDG TOML configuration here.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.hunk;
  toml = pkgs.formats.toml {};
in {
  options.programs.hunk = {
    enable = lib.mkEnableOption "Hunk diff viewer";
    package = lib.mkOption {
      type = lib.types.package;
      description = "Hunk package to install.";
    };
    settings = lib.mkOption {
      inherit (toml) type;
      default = {};
      description = "Settings written to the Hunk XDG config.toml file.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."hunk/config.toml" = {
      source = toml.generate "hunk-config.toml" cfg.settings;
      # Adopt the existing unmanaged config file on the first switch.
      force = true;
    };
  };
}
