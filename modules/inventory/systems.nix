# Den derives supported systems from the host/home inventory and forwards them
# to flake-parts. Extend den.systems only for platforms without declared hosts.
{den, ...}: {
  flake.inventory.systems = den.systems;
}
