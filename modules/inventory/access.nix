# A serializable view for tools and humans; do not export functions/entities.
# Account membership is not an SSH ACL or a claim that remote login is enabled.
{
  den,
  lib,
  ...
}: {
  options.flake.inventory = lib.mkOption {
    description = "Serializable host/user inventory and supported systems.";
    default = {};
    type = lib.types.submodule {
      options = {
        hosts = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf lib.types.attrs);
          default = {};
        };
        systems = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
        };
      };
    };
  };
  config.flake.inventory.hosts = lib.mapAttrs (_: hosts:
    lib.mapAttrs (_: host: {
      inherit (host) name hostName system class;
      users =
        lib.mapAttrs (_: user: {
          inherit (user) userName classes;
        })
        host.users;
    })
    hosts)
  den.hosts;
}
