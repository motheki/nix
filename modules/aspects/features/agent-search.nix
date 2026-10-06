# One store-pinned server identity, with each client's native configuration.
# This capability is independent of a particular username or host profile path.
{
  den.aspects.features.agent-search.homeManager = {
    lib,
    pkgs,
    ...
  }: let
    fff = import ../../_lib/fff.nix {inherit lib pkgs;};
  in {
    home.packages = [pkgs.fff-mcp];
    programs = {
      mcp = {
        enable = true;
        servers.fff = fff.server;
      };
      codex = {
        enableMcpIntegration = true;
        inherit (fff) context;
        # HM treats a per-client server override as a whole identity.
        settings.mcp_servers.fff =
          fff.server
          // {
            enabled_tools = fff.tools;
            tools = lib.genAttrs fff.tools (_: {approval_mode = "approve";});
          };
      };
    };
  };
}
