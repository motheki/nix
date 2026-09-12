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
  expectedUserToolPaths = [
    "${h.home.homeDirectory}/Library/Android/sdk/emulator"
    "${h.home.homeDirectory}/Library/Android/sdk/platform-tools"
    "${h.home.homeDirectory}/.local/bin"
    "${h.home.homeDirectory}/.npm/bin"
    "${h.home.homeDirectory}/Library/pnpm/bin"
    "${h.home.homeDirectory}/Library/pnpm"
    "${h.home.homeDirectory}/.yarn/bin"
    "${h.home.homeDirectory}/.bun/bin"
    "${h.home.homeDirectory}/.cargo/bin"
    "${h.home.homeDirectory}/go/bin"
  ];
  commandNames = builtins.attrNames config.flake.lib.commandSpecs;
  fff = import ./_lib/fff.nix {inherit lib;};
  fxMcp = builtins.fromJSON h.home.file.".fx/mcp.json".text;
  piFff = builtins.fromJSON h.home.file.".pi/agent/pi-fff.json".text;
  piSettings = h.programs.pi-coding-agent.settings;
  expectedPiPackages = [
    "npm:@ff-labs/pi-fff"
    "npm:@narumitw/pi-goal"
    "npm:@narumitw/pi-plan-mode"
    "npm:pi-lens"
    "npm:@ogulcancelik/pi-codex-compaction"
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
    automaticShell =
      h.programs.direnv.enable
      && h.programs.direnv.nix-direnv.enable
      && lib.all (shell: h.programs.direnv."enable${shell}Integration") ["Zsh" "Bash" "Fish" "Nushell"];
    fffInstalled = lib.any (brew: brew.name == "dmtrkovalenko/fff/fff-mcp") c.homebrew.brews;
    fffSharedServer = h.programs.mcp.enable && h.programs.mcp.servers.fff.command == fff.server.command;
    fffFx =
      fxMcp.mcp.fff
      == {
        type = "stdio";
        command = [fff.server.command];
      }
      && !h.home.file.".fx/settings.json".enable
      && (builtins.fromJSON h.home.file.".fx/settings.json".text).permission == fff.fxPermissions;
    mutableAgentProfiles = let
      clientProfiles = import ./_lib/client-profiles.nix {
        inherit lib;
        pkgs = c.nixpkgs.pkgs;
        config = h;
      };
    in
      lib.all (profile: lib.any (file: file.target == profile.path && !file.enable && !file.force) (builtins.attrValues h.home.file)) clientProfiles.profiles
      && lib.elem "writeBoundary" h.home.activation.checkAgentProfiles.before
      && lib.elem "writeBoundary" h.home.activation.mergeAgentProfiles.after
      && lib.elem "linkGeneration" h.home.activation.mergeAgentProfiles.before
      && lib.hasInfix "--check" h.home.activation.checkAgentProfiles.data
      && lib.hasInfix "run " h.home.activation.mergeAgentProfiles.data;
    fffCodex =
      h.programs.codex.enableMcpIntegration
      && h.programs.codex.settings.mcp_servers.fff.command == fff.server.command
      && h.programs.codex.settings.mcp_servers.fff.enabled_tools == fff.tools
      && lib.all (name: h.programs.codex.settings.mcp_servers.fff.tools.${name}.approval_mode == "approve") fff.tools;
    fffOpenCode =
      h.programs.opencode.enableMcpIntegration
      && h.programs.opencode.settings.permission == fff.opencodePermissions;
    boundedPiFff =
      piFff
      == {
        enableHomeDirScanning = false;
        enableFsRootScanning = false;
        followSymlinks = false;
      };
    selectivePiExtensions =
      h.programs.pi-coding-agent.enable
      && piSettings.packages == expectedPiPackages
      && h.home.file."${h.home.homeDirectory}/.pi/agent/settings.json".force;
    oneCompletionOwner = !c.programs.zsh.enableGlobalCompInit && h.programs.zsh.enableCompletion;
    userToolPaths =
      h.home.sessionVariables.PNPM_HOME
      == "${h.home.homeDirectory}/Library/pnpm"
      && lib.all (path: lib.elem path h.home.sessionPath) expectedUserToolPaths;
    fixedStateVersions = c.system.stateVersion == 7 && h.home.stateVersion == "26.11";
    flakeOnlyNixPath = c.nix.nixPath == ["nixpkgs=flake:nixpkgs"];
    directPackageSources = inputs ? llm-agents && inputs ? nix-homebrew && !(inputs ? omniflake);
    oneFlakeParts =
      inputs.flake-parts.rev
      == inputs.llm-agents.inputs.flake-parts.rev
      && inputs.flake-parts.rev == inputs.nixvim.inputs.flake-parts.rev
      && inputs.flake-parts.rev == inputs.devenv.inputs.flake-parts.rev;
    oneNixpkgs =
      inputs.nixpkgs.rev
      == inputs.darwin.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.home-manager.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.llm-agents.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.nixvim.inputs.nixpkgs.rev
      && inputs.nixpkgs.rev == inputs.devenv.inputs.nixpkgs.rev;
    oneTreefmt =
      inputs.treefmt-nix.rev
      == inputs.llm-agents.inputs.treefmt-nix.rev
      && inputs.treefmt-nix.rev == inputs.devenv.inputs.nixd.inputs.treefmt-nix.rev;
    oneBrewSource = inputs.brew-src.rev == inputs.nix-homebrew.inputs.brew-src.rev;
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
      commands = import ../tests/commands.nix {inherit pkgs lib;};
      development = import ../tests/development.nix {inherit pkgs lib config;};
      fff-profiles = import ../tests/fff.nix {
        inherit pkgs lib;
        config = h;
        inherit (inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}) fx codex;
      };
      command-wrappers = assert lib.assertMsg (builtins.hasAttr "write-all" config.packages) "The write-all compatibility package is missing";
      assert lib.assertMsg
      (lib.all (name: !builtins.hasAttr name config.packages) [
        "devenv-up"
        "devenv-test"
        "mobile-devenv-up"
        "mobile-devenv-test"
        "systems-devenv-up"
        "systems-devenv-test"
      ])
      "Deprecated devenv compatibility packages leaked into the public package surface";
        pkgs.runCommand "configuration-command-wrapper-tests" {} ''
          ${lib.concatMapStringsSep "\n" (name: ''
              ${config.packages.${name}}/bin/${name} --help > /dev/null
            '')
            commandNames}
          touch "$out"
        '';
    };
  };
}
