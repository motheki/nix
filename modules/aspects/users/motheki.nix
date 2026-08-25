# User identity and composition only. Feature implementation lives in the
# profiles below so this file remains a readable inventory of the home setup.
{den, ...}: {
  den.aspects.motheki.includes = [
    den.batteries.primary-user
    (den.batteries.user-shell "zsh")
    den.aspects.profiles.applications
    den.aspects.profiles.command-line
    den.aspects.profiles.development
    den.aspects.profiles.llm-agents
    den.aspects.profiles.packages
    den.aspects.profiles.shell
    den.aspects.profiles.nixvim
    den.aspects.profiles.version-control
  ];
}
