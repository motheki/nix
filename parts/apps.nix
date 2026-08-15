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
        nix flake update --flake "$flake_path" "$@"
      '';
    };
  in {
    apps.update-inputs = {
      type = "app";
      program = "${updateInputs}/bin/update-inputs";
      meta.description = "Update flake inputs according to flake.nix";
    };
  };
}
