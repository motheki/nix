# Fast checks build small test derivations. CI builds the actual host separately.
{
  config,
  lib,
  inputs,
  ...
}: let
  host = config.flake.darwinConfigurations.mothekis-macbook-pro;
  c = host.config;
  h = c.home-manager.users.motheki;
  policy = import ./_lib/maintenance.nix;
  caskRenames = builtins.fromJSON (builtins.readFile "${inputs.homebrew-cask}/cask_renames.json");
  caskNames = map (cask: cask.name) c.homebrew.casks;
  userArgs = h.launchd.agents.nix-user-cleanup.config.ProgramArguments;
  systemArgs = c.launchd.daemons.nix-profile-cleanup.serviceConfig.ProgramArguments;
  expectedUserArgs = ["clean" "user" "--no-gc"] ++ policy.retentionArgs ++ policy.preserveRootsArgs;
  expectedSystemArgs = ["clean" "profile" policy.systemProfile] ++ policy.retentionArgs ++ policy.preserveRootsArgs;
  commandNames = [
    "check"
    "build"
    "switch"
    "dependencies"
    "update-core"
    "update-tools"
    "update-homebrew"
    "maintenance"
    "doctor"
    "diagram"
    "benchmark"
  ];
  invariants = {
    safeHomebrew =
      !c.homebrew.onActivation.autoUpdate
      && !c.homebrew.onActivation.upgrade
      && c.homebrew.onActivation.cleanup == "none"
      && !c.homebrew.greedyCasks
      && !c.homebrew.global.autoUpdate;
    canonicalCasks =
      builtins.length caskNames
      == builtins.length (lib.unique caskNames)
      && lib.all (name: !(builtins.hasAttr name caskRenames)) caskNames;
    sharedPackages =
      c.home-manager.useGlobalPkgs
      && c.home-manager.useUserPackages
      && h.programs.nixvim.nixpkgs.useGlobalPackages;
    boundedBuilds = c.nix.settings.max-jobs == 2 && c.nix.settings.cores == 4;
    userCleanup = builtins.tail userArgs == expectedUserArgs && !h.programs.nh.clean.enable;
    systemCleanup = builtins.tail systemArgs == expectedSystemArgs && !c.nix.gc.automatic;
    separateOptimisation = c.nix.optimise.automatic && !c.nix.settings.auto-optimise-store;
    noUnsupportedRadicleDaemon = !h.services.radicle.node.enable && h.programs.radicle.enable;
    relativeApplications = h.targets.darwin.copyApps.directory == "Applications/home-manager";
    oneMiseActivation = !h.programs.mise.enableZshIntegration && h.programs.direnv.mise.enable;
    oneCompletionOwner = !c.programs.zsh.enableGlobalCompInit && h.programs.zsh.enableCompletion;
    noMutableRuntimePaths = lib.all (path:
      !(lib.elem path [
        "${h.home.homeDirectory}/.bun/bin"
        "${h.home.homeDirectory}/.cargo/bin"
      ]))
    h.home.sessionPath;
    fixedStateVersions = c.system.stateVersion == 7 && h.home.stateVersion == "26.11";
    oneFlakeParts =
      inputs.flake-parts.rev
      == inputs.omniflake.inputs.flake-parts.rev
      && inputs.flake-parts.rev == inputs.nixvim.inputs.flake-parts.rev;
    oneNixpkgs =
      inputs.nixpkgs.rev
      == inputs.darwin.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.home-manager.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.nixvim.inputs.nixpkgs.rev;
  };
in {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    checks = {
      host-policy = assert lib.assertMsg (lib.all (value: value) (builtins.attrValues invariants))
      "Host policy failed: ${builtins.toJSON invariants}";
        pkgs.runCommand "host-policy" {
          # Force the complete host derivation without building the closure here.
          evaluatedHost = builtins.unsafeDiscardStringContext host.system.drvPath;
          report = builtins.toJSON invariants;
        } ''
          test -n "$evaluatedHost"
          printf '%s\n' "$report" > "$out"
        '';
      commands =
        pkgs.runCommand "configuration-command-tests" {
          nativeBuildInputs = with pkgs; [bash python3 jq shellcheck];
          CONFIG_SCRIPTS = ../scripts;
        } ''
          export PYTHONDONTWRITEBYTECODE=1
          shellcheck ${../scripts/config.sh}
          python3 -m unittest discover -s ${../tests} -v
          touch "$out"
        '';
      command-wrappers = pkgs.runCommand "configuration-command-wrapper-tests" {} ''
        ${lib.concatMapStringsSep "\n" (name: ''
            ${config.packages.${name}}/bin/${name} --help > /dev/null
          '')
          commandNames}
        touch "$out"
      '';
    };
  };
}
