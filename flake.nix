{
  description = "mothkeki's system flake";

  inputs = {
    nixpkgs.url = "github:numtide/nixpkgs-unfree/main";
    determinate = {url = "github:DeterminateSystems/determinate/main";};
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
    };
    nix-homebrew = {url = "github:zhaofengli-wip/nix-homebrew/main";};
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    devenv.url = "github:cachix/devenv/main";
    ez-configs.url = "github:ehllie/ez-configs/main";
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
  };

  outputs = inputs @ {
    flake-parts,
    devenv-root,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.devenv.flakeModule
        inputs.ez-configs.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      ezConfigs.root = ./.;
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        treefmt = {
          programs = {
            alejandra.enable = true;
          };
        };
        devenv.shells.default = {
          devenv.root = let
            devenvRootFileContent = builtins.readFile devenv-root.outPath;
          in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
          name = "os-flake";
          languages.nix.enable = true;
        };
      };
    };
}
