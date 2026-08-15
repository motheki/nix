{
  description = "Motheki's Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    den = {
      url = "github:denful/den/main";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix/main";
    };
    import-tree = {
      url = "github:denful/import-tree/main";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/main";
      inputs.brew-src = {
        url = "github:Homebrew/brew/main";
        flake = false;
      };
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core/main";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask/main";
      flake = false;
    };
    fff-mcp = {
      url = "github:dmtrKovalenko/homebrew-fff/main";
      flake = false;
    };
    hax = {
      url = "github:OleksandrChekhovskyi/homebrew-hax/master";
      flake = false;
    };
    apple-simutil = {
      url = "github:wix/homebrew-brew/master";
      flake = false;
    };
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./parts);
}
