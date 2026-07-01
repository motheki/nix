_: let
  localFlakePath = "/Users/motheki/Repos/personal/nix";
in {
  systems = ["aarch64-darwin"];

  perSystem = {pkgs, ...}: let
    updateInputs = pkgs.writeShellApplication {
      name = "update-inputs";
      runtimeInputs = [pkgs.nix];
      text = ''
        flake_path="''${NH_DARWIN_FLAKE:-${localFlakePath}}"
        nix flake update "$flake_path" "$@"
      '';
    };

    darwinSwitch = pkgs.writeShellApplication {
      name = "darwin-switch";
      runtimeInputs = [pkgs.nh];
      text = ''
        flake_path="''${NH_DARWIN_FLAKE:-${localFlakePath}}"
        nh darwin switch "$flake_path" "$@"
      '';
    };

    clean = pkgs.writeShellApplication {
      name = "clean";
      runtimeInputs = [pkgs.nh];
      text = ''
        nh clean all -q "$@"
      '';
    };
  in {
    apps = {
      clean = {
        type = "app";
        program = "${clean}/bin/clean";
        meta.description = "Clean Nix generations with nh from this flake's nixpkgs";
      };

      darwin-switch = {
        type = "app";
        program = "${darwinSwitch}/bin/darwin-switch";
        meta.description = "Switch the nix-darwin configuration with nh from this flake's nixpkgs";
      };

      update-inputs = {
        type = "app";
        program = "${updateInputs}/bin/update-inputs";
        meta.description = "Update flake inputs according to flake.nix";
      };
    };
  };
}
