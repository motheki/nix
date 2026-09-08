# Everyday tools. Project shells own language versions, while user-level bin
# directories expose globally installed tools that can move faster than nixpkgs.
{
  den.aspects.features.development.homeManager = {
    config,
    pkgs,
    ...
  }: let
    homeDirectory = config.home.homeDirectory;
    pnpmHome = "${homeDirectory}/Library/pnpm";
  in {
    home = {
      packages = [pkgs.nodejs pkgs.pnpm];
      sessionVariables.PNPM_HOME = pnpmHome;
      sessionPath = [
        # Shared by uv, pipx, and other XDG-aware installers.
        "${homeDirectory}/.local/bin"
        "${homeDirectory}/.npm/bin"
        # pnpm 11 writes global executables below PNPM_HOME/bin. Keep the root
        # for global shims created by pnpm 10 and earlier.
        "${pnpmHome}/bin"
        pnpmHome
        "${homeDirectory}/.yarn/bin"
        "${homeDirectory}/.bun/bin"
        "${homeDirectory}/.cargo/bin"
        "${homeDirectory}/go/bin"
      ];
    };
    programs = {
      awscli.enable = true;
      bun.enable = true;
      devenv.enable = true;
      docker-cli.enable = true;
      npm.enable = true;
      uv.enable = true;
      yarn.enable = true;
    };
  };
}
