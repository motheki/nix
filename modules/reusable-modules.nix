# Plain modules can be imported by other flakes without personal inventory.
{den, ...}: {
  flake = {
    homeManagerModules = {
      agent-search = den.aspects.features.agent-search.homeManager;
      coding-agents = den.aspects.features.coding-agents.homeManager;
      code-review = den.aspects.features.code-review.homeManager;
      hunk = ./_modules/home-manager/hunk.nix;
      tuicr = ./_modules/home-manager/tuicr.nix;
    };
    devenvModules = {
      default = ./_modules/devenv/default.nix;
      mobile = ./_modules/devenv/mobile.nix;
      systems = ./_modules/devenv/systems.nix;
    };
  };
}
