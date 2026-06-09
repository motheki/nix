{inputs, ...}: let
  denInputs = removeAttrs inputs ["flake-parts"];
  denConfig =
    (inputs.nixpkgs.lib.evalModules {
      modules = [
        (inputs.import-tree ../modules)
      ];
      specialArgs = {inputs = denInputs;};
    }).config;
in {
  systems = ["aarch64-darwin"];

  perSystem = {pkgs, ...}: let
    checkInputPolicy = pkgs.writeShellApplication {
      name = "check-flake-input-policy";
      runtimeInputs = [pkgs.jq];
      text = ''
        lock_path="''${1:-flake.lock}"

        while read -r input expected_ref; do
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
        done <<'POLICY'
        darwin master
        den main
        flake-parts main
        home-manager master
        homebrew-cask main
        homebrew-core main
        import-tree main
        mac-app-util master
        nix-homebrew main
        nixpkgs master
        nixvim main
        nur main
        treefmt-nix main
        POLICY

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
        nix flake update /Users/motheki/Repos/personal/nix "$@"
      '';
    };
    darwinSwitch = pkgs.writeShellApplication {
      name = "darwin-switch";
      runtimeInputs = [pkgs.nh];
      text = ''
        nh darwin switch /Users/motheki/Repos/personal/nix "$@"
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
    apps.clean = {
      type = "app";
      program = "${clean}/bin/clean";
      meta.description = "Clean Nix generations with nh from this flake's nixpkgs";
    };

    apps.darwin-switch = {
      type = "app";
      program = "${darwinSwitch}/bin/darwin-switch";
      meta.description = "Switch the nix-darwin configuration with nh from this flake's nixpkgs";
    };

    apps.update-inputs = {
      type = "app";
      program = "${updateInputs}/bin/update-inputs";
      meta.description = "Update all flake inputs to their tracked branch heads";
    };

    checks.flake-input-policy = pkgs.runCommand "flake-input-policy" {} ''
      ${checkInputPolicy}/bin/check-flake-input-policy ${../flake.lock}
      touch $out
    '';
  };

  flake = {
    inherit (denConfig.flake) darwinConfigurations;
  };
}
