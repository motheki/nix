# fx reads its own global MCP profile, not $XDG_CONFIG_HOME/mcp/mcp.json.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.fx;
  json = pkgs.formats.json {};
  sharedServers = lib.optionalAttrs cfg.enableMcpIntegration (
    lib.mapAttrs (name: server:
      lib.hm.mcp.transformMcpServer {
        inherit server;
        extraTransforms = [
          lib.hm.mcp.addType
          (lib.hm.mcp.wrapEnvFilesCommand {inherit pkgs name;})
        ];
      })
    config.programs.mcp.servers
  );
  # A client override replaces the entire server identity, including its transport.
  servers = sharedServers // cfg.mcpServers;
in {
  options.programs.fx = {
    enable = lib.mkEnableOption "fx coding agent";
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      description = "fx package to install, or null to manage only MCP configuration.";
    };
    enableMcpIntegration = lib.mkEnableOption "shared programs.mcp servers in fx";
    mcpServers = lib.mkOption {
      type = lib.types.attrsOf json.type;
      default = {};
      description = ''
        fx-native MCP server entries. Each entry replaces a same-name shared
        programs.mcp server. The resulting global MCP profile is managed by
        Home Manager; add servers here rather than through fx mcp add.
        Personal settings, credentials, sessions, and trust remain owned by fx.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optional (cfg.package != null) cfg.package;
    assertions = [
      {
        assertion = cfg.enableMcpIntegration -> config.programs.mcp.enable;
        message = "programs.fx.enableMcpIntegration requires programs.mcp.enable.";
      }
    ];
    home.file.".fx/mcp.json" = lib.mkIf (servers != {}) {
      source = json.generate "fx-mcp.json" {mcp = servers;};
    };
  };
}
