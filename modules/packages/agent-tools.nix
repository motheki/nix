# Publish selected upstream packages directly; no private wrappers or overlay.
{
  inputs,
  den,
  ...
}: {
  den.schema.flake-system.includes = [den.aspects.agent-tools];
  den.aspects.agent-tools.packages = {pkgs, ...}: {
    inherit
      (inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system})
      herdr
      hunk
      tuicr
      claude-code
      claude-desktop
      ;
    inherit (pkgs) fff-mcp;
  };
}
