# tuicr has no Home Manager module; generate its XDG TOML configuration and themes.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.tuicr;
  toml = pkgs.formats.toml {};
  rosePine = import ./tuicr-rose-pine.nix;
in {
  options.programs.tuicr = {
    enable = lib.mkEnableOption "tuicr code review TUI";
    package = lib.mkOption {
      type = lib.types.package;
      description = "tuicr package to install.";
    };
    settings = lib.mkOption {
      inherit (toml) type;
      default = {};
      description = "Settings written to the tuicr XDG config.toml file.";
    };
    themes = lib.mkOption {
      type = lib.types.attrsOf toml.type;
      default = rosePine;
      description = "Local themes written to tuicr/themes/<name>.toml.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile =
      {
        "tuicr/config.toml" = {
          source = toml.generate "tuicr-config.toml" cfg.settings;
        };
      }
      // lib.mapAttrs' (name: theme: {
        name = "tuicr/themes/${name}.toml";
        value.source = toml.generate "tuicr-${name}.toml" theme;
      })
      cfg.themes;
  };
}
