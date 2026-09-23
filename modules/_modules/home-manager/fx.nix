# fx owns its writable profile. Use documented process overrides, not file links
# or activation mergers, for declarative configuration.
{
  config,
  lib,
  ...
}: let
  cfg = config.programs.fx;
in {
  options.programs.fx = {
    enable = lib.mkEnableOption "fx coding agent";
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      description = "fx package to install, or null to manage only environment overrides.";
    };
    autoUpgrade = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow fx's automatic upgrades. Disabled by default for a Nix-managed package.";
    };
    environment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      example = {
        FX_PERMISSION_MODE = "auto";
        FX_THEME = "dark";
      };
      description = ''
        Non-secret, documented fx environment overrides exported through Home
        Manager session variables. Global MCP servers, permission rules, personal
        instructions, credentials, and saved settings remain native fx profile
        state. Never put API keys or other secrets here; Nix store files are public.
        Use autoUpgrade rather than setting FX_AUTO_UPGRADE here.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optional (cfg.package != null) cfg.package;
    home.sessionVariables =
      cfg.environment
      // {
        FX_AUTO_UPGRADE =
          if cfg.autoUpgrade
          then "1"
          else "0";
      };
  };
}
