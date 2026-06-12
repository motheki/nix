_: let
  localFlakePath = "/Users/motheki/Repos/personal/nix";

  trackedBranchInputs = {
    darwin = "master";
    den = "main";
    flake-parts = "main";
    home-manager = "master";
    homebrew-cask = "main";
    homebrew-core = "main";
    import-tree = "main";
    mac-app-util = "master";
    nix-homebrew = "main";
    nixpkgs = "master";
    nixvim = "main";
    nur = "main";
    treefmt-nix = "main";
  };
in {
  systems = ["aarch64-darwin"];

  perSystem = {pkgs, ...}: let
    inputPolicyFile = pkgs.writeText "tracked-flake-inputs.json" (builtins.toJSON trackedBranchInputs);

    checkInputPolicy = pkgs.writeShellApplication {
      name = "check-flake-input-policy";
      runtimeInputs = [pkgs.jq];
      text = ''
        lock_path="''${1:-flake.lock}"

        jq -r 'to_entries[] | "\(.key)\t\(.value)"' ${inputPolicyFile} |
          while IFS="$(printf '\t')" read -r input expected_ref; do
            node="$(jq -r --arg input "$input" '.nodes.root.inputs[$input] // empty' "$lock_path")"
            if [ -z "$node" ]; then
              echo "missing root input: $input" >&2
              exit 1
            fi

            actual_ref="$(jq -r --arg node "$node" '.nodes[$node].original.ref // empty' "$lock_path")"
            if [ "$actual_ref" != "$expected_ref" ]; then
              echo "$input should track $expected_ref, got ''${actual_ref:-<none>}" >&2
              exit 1
            fi
          done

        nixpkgs_nodes="$(jq -r '[.nodes | keys[] | select(test("^nixpkgs(_[0-9]+)?$"))] | length' "$lock_path")"
        if [ "$nixpkgs_nodes" -ne 1 ]; then
          jq -r '.nodes | keys[] | select(test("^nixpkgs(_[0-9]+)?$"))' "$lock_path" >&2
          echo "expected exactly one nixpkgs lock node, got $nixpkgs_nodes" >&2
          exit 1
        fi
      '';
    };

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
        meta.description = "Update all flake inputs to their tracked branch heads";
      };
    };

    checks.flake-input-policy = pkgs.runCommand "flake-input-policy" {} ''
      ${checkInputPolicy}/bin/check-flake-input-policy ${../flake.lock}
      touch $out
    '';
  };
}
