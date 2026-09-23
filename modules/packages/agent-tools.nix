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
      fx
      opencode2
      pi
      herdr
      hunk
      tuicr
      ;
    inherit (pkgs) fff-mcp;
  };
}
