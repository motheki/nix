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
        herdr
        hunk
        tuicr
        claude-code
        ;
      inherit (pkgs) fff-mcp;
    };
  };
}
