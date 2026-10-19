# CLI packages can also be built independently of the workstation configuration.
{
  perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    packages = {
      inherit
        (inputs'.llm-agents.packages)
        hax
        ;
      inherit (pkgs) fff-mcp;
    };
  };
}
