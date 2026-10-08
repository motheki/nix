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
        codex
        hax
        t3code
        t3code-desktop
        fx
        opencode2
        hunk
        claude-code
        ;
      inherit (pkgs) fff-mcp;
    };
  };
}
