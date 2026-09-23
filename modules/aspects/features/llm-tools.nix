# A profile composes agent capabilities; it performs no runtime profile merging.
{den, ...}: {
  den.aspects.features.llm-tools.includes = with den.aspects.features; [
    coding-agents
    agent-search
    code-review
  ];
}
