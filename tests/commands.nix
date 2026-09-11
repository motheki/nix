# Integration: checks.commands = import ../tests/commands.nix { inherit pkgs lib; };
{
  pkgs,
  lib,
}: let
  specs = import ../modules/_lib/command-specs.nix {inherit lib;};
  render = import ../modules/_lib/command-diagram.nix {inherit lib;};
  trace = [
    {
      name = "child\"";
      parent = "root";
    }
    {
      name = "root";
      parent = "root";
    }
  ];
  fails = value: !(builtins.tryEval (builtins.deepSeq (render value) true)).success;
  pureTests = {
    testNames = {
      expr = builtins.attrNames specs;
      expected = ["benchmark" "build" "check" "dependencies" "diagram" "doctor" "maintenance" "switch" "update-all" "update-core" "update-homebrew" "update-tools"];
    };
    testUpdateAll = {
      expr = specs.update-all.inputs;
      expected = [];
    };
    testUpdateCore = {
      expr = specs.update-core.inputs;
      expected = ["nixpkgs" "darwin" "home-manager" "den" "devenv" "flake-parts" "flake-file" "import-tree" "nixvim" "treefmt-nix"];
    };
    testUpdateTools = {
      expr = specs.update-tools.inputs;
      expected = ["llm-agents"];
    };
    testUpdateHomebrew = {
      expr = specs.update-homebrew.inputs;
      expected = ["nix-homebrew" "brew-src" "homebrew-core" "homebrew-cask" "fff-mcp"];
    };
    testDisjoint = {
      expr = let xs = lib.concatMap (n: specs.${n}.inputs) ["update-core" "update-tools" "update-homebrew"]; in builtins.length xs == builtins.length (lib.unique xs);
      expected = true;
    };
    testArgumentPolicies = {
      expr = lib.mapAttrs (_: s: s.arguments) specs;
      expected =
        lib.genAttrs ["benchmark" "check" "dependencies" "diagram" "doctor" "update-all" "update-core" "update-homebrew" "update-tools"] (_: "none")
        // {
          build = "passthrough";
          switch = "passthrough";
          maintenance = "maintenance";
        };
    };
    testEmpty = {
      expr = render [];
      expected = "flowchart TD\n";
    };
    testDeterminism = {
      expr = render trace;
      expected = render (lib.reverseList trace ++ trace);
    };
    testHashAndEscaping = {
      expr = render [{name = "root";}];
      expected = "flowchart TD\n  n4813494d137e1631[\"root\"]\n";
    };
    testEscaping = {
      expr = lib.hasInfix "&amp;&lt;&gt;&quot;&#x27; " (render [{name = "&<>\"'\n";}]);
      expected = true;
    };
    testSingleEdge = {
      expr = builtins.length (lib.splitString " --> " (render trace));
      expected = 2;
    };
    testPath = {
      expr = render [
        {
          name = "unused";
          path = "child";
          parent = "root";
        }
      ];
      expected = render [
        {
          name = "child";
          parent = "root";
        }
      ];
    };
    testEmptyPathFallback = {
      expr = render [
        {
          name = "root";
          path = "";
        }
      ];
      expected = render [{name = "root";}];
    };
    testNullPathFallback = {
      expr = render [
        {
          name = "root";
          path = null;
        }
      ];
      expected = render [{name = "root";}];
    };
    testInvalid = {
      expr = map fails [
        null
        {}
        [{}]
        [1]
        [{name = 1;}]
        [
          {
            name = "x";
            parent = [];
          }
        ]
      ];
      expected = lib.replicate 6 true;
    };
  };
  failures = lib.runTests pureTests;
  mock = pkgs.runCommand "configuration-mock-tools" {} (lib.concatMapStringsSep "\n" (name: ''
    mkdir -p "$out/bin"
    cat > "$out/bin/${name}" <<'MOCK'
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    name=${lib.escapeShellArg name}
    jq -cn --args '$ARGS.positional' -- "$name" "$@" >> "$CALL_LOG"
    if [[ ''${FAIL_COMMAND:-} == "$name" ]]; then exit 7; fi
    case "$name" in
      nix)
        case "$*" in
          *maintenancePolicy*) printf '%s\n' "$POLICY" ;;
          *dependencyManifest*)
            revision=old; if [[ -e $UPDATED ]]; then revision=new; fi
            printf '{"z-last":true,"revision":"%s","a-first":true}\n' "$revision" ;;
          *aspectDiagram*) printf '%s' ${lib.escapeShellArg (render trace)} ;;
          *homebrew.brewfile*) printf 'cask "example"\n' ;;
          'flake update '*) touch "$UPDATED" ;;
        esac ;;
      launchctl) exit 1 ;;
      sudo)
        # Only our own mocks may be executed, even if a test regresses.
        case "$(readlink -f "$1")" in
          "$MOCK_BIN/nh"|"$MOCK_BIN/nix") exec "$@" ;;
          *) echo 'Refusing non-mock sudo target' >&2; exit 99 ;;
        esac ;;
      diff) exec ${pkgs.diffutils}/bin/diff "$@" ;;
    esac
    MOCK
    chmod +x "$out/bin/${name}"
  '') ["nix" "nh" "sudo" "brew" "launchctl" "diff"]);
  # No real maintenance executables in PATH; sudo/launchctl live alongside nh/nix.
  tools = {
    nix = mock;
    nh = mock;
    inherit (pkgs) jq;
    inherit (pkgs) coreutils;
    diffutils = mock;
  };
  apps = import ../modules/_lib/command-apps.nix {
    inherit pkgs lib tools;
    hostName = "default-host";
    inheritPath = false;
  };
  # All mocks need jq/coreutils even when the production command does not.
  testApps = import ../modules/_lib/command-apps.nix {
    inherit pkgs lib;
    hostName = "default-host";
    inheritPath = false;
    tools = lib.mapAttrs (_: _:
      pkgs.symlinkJoin {
        name = "isolated-command-tools";
        paths = [mock pkgs.jq pkgs.coreutils];
      })
    tools;
  };
  run = name: "${testApps.${name}}/bin/${name}";
  cases =
    {
      check = ''
        ${run "check"}
        calls 'length == 1 and .[0] == ["nix","flake","check","--impure","--no-write-lock-file",env.NIX_CONFIG_REPO]'
      '';
      build = ''
        ${run "build"} --dry-run 'argument with spaces'
        calls '. == [["nix","build","--no-write-lock-file","--no-link",(env.NIX_CONFIG_REPO + "#darwinConfigurations.test-host.system"),"--dry-run","argument with spaces"]]'
      '';
      switch = ''
        ${run "switch"} --verbose
        calls '. == [["nh","darwin","switch",env.NIX_CONFIG_REPO,"--hostname","test-host","--ask","--no-write-lock-file","--verbose"]]'
      '';
      checkout = ''
        unset NIX_CONFIG_REPO
        export NH_DARWIN_FLAKE=/wrong-checkout
        ${run "build"}
        calls '.[0][4] == (env.REPOSITORY + "#darwinConfigurations.test-host.system")'
      '';
      fallback = ''
        unset NIX_CONFIG_REPO NIX_CONFIG_HOST
        export NH_DARWIN_FLAKE="$REPOSITORY"
        cd "$TMPDIR"
        ${run "build"}
        calls '.[0][4] == (env.REPOSITORY + "#darwinConfigurations.default-host.system")'
      '';
      override = ''
        mkdir -p "$TMPDIR/other/modules"
        touch "$TMPDIR/other/flake.nix" "$TMPDIR/other/modules/hosts.nix"
        export NIX_CONFIG_REPO="$TMPDIR/other"
        ${run "build"}
        calls '.[0][4] == (env.NIX_CONFIG_REPO + "#darwinConfigurations.test-host.system")'
      '';
      preview = ''
        ${run "maintenance"} --optimise
        calls '[.[] | select(.[0] == "nh")] == [["nh","clean","user","--dry","--no-gc","--keep","5","--keep-since","14d","--no-gcroots","--no-direnv"],["nh","clean","profile","/nix/var/nix/profiles/system","--dry","--keep","5","--keep-since","14d","--no-gcroots","--no-direnv"]]'
        calls 'all(.[]; .[0] != "sudo" and .[0] != "brew")'
      '';
      selectedPolicy = ''
        export POLICY='{"retentionArgs":["--keep","7","--keep-since","30d"],"preserveRootsArgs":["--no-gcroots","--no-direnv"],"systemProfile":"/nix/var/nix/profiles/other-system"}'
        ${run "maintenance"}
        calls '.[0] == ["nix","eval","--no-write-lock-file","--json",(env.NIX_CONFIG_REPO + "#lib.maintenancePolicy")]'
        calls '[.[] | select(.[0] == "nh")] | all(.[]; index("7") != null and index("30d") != null) and (.[1] | index("/nix/var/nix/profiles/other-system") != null)'
      '';
      apply = ''
        ${run "maintenance"} --apply --optimise
        calls '[.[] | select(.[0] == "nh")] == [["nh","clean","user","--no-gc","--keep","5","--keep-since","14d","--no-gcroots","--no-direnv"],["nh","clean","profile","/nix/var/nix/profiles/system","--keep","5","--keep-since","14d","--no-gcroots","--no-direnv"]]'
        calls '[.[] | select(.[0] == "sudo")] | length == 2'
        calls '.[-1] == ["nix","store","optimise"]'
      '';
      invalidPolicy =
        lib.concatMapStringsSep "\n" (policy: ''
          export POLICY=${lib.escapeShellArg policy}
          reject 1 ${run "maintenance"} --apply
          calls 'all(.[]; .[0] == "nix")'
        '') (["not json" "{}"]
          ++ map builtins.toJSON [
            {
              retentionArgs = [];
              preserveRootsArgs = [];
            }
            ((import ../modules/_lib/maintenance.nix) // {retentionArgs = [];})
            ((import ../modules/_lib/maintenance.nix) // {retentionArgs = ["--keep" "0" "--keep-since" "14d"];})
            ((import ../modules/_lib/maintenance.nix) // {systemProfile = "/wrong-profile";})
            ((import ../modules/_lib/maintenance.nix) // {preserveRootsArgs = ["--gcroots"];})
            ((import ../modules/_lib/maintenance.nix) // {retentionArgs = ["--keep" "5" "--keep-since" "14d\n--all"];})
          ]);
      brewPreview = ''
        ${run "maintenance"} --brew
        calls '[.[] | select(.[0] == "brew")] == [["brew","outdated"]]'
        calls 'all(.[]; .[0] != "sudo")'
      '';
      brewApply = ''
        ${run "maintenance"} --brew --apply
        calls '[.[] | select(.[0] == "brew")] | length == 1 and .[0][1:3] == ["bundle","install"] and (.[0][3] | startswith("--file="))'
      '';
      missingBrew = ''
        export NIX_CONFIG_BREW=/nonexistent
        reject 2 ${run "maintenance"} --brew --apply
        calls 'all(.[]; .[0] == "nix")'
      '';
      dependencies = ''
        ${run "dependencies"} > manifest.json
        test "$(jq -r 'keys_unsorted | join(",")' manifest.json)" = a-first,revision,z-last
        calls 'length == 1 and (.[0][-1] | endswith("#lib.dependencyManifest"))'
      '';
      doctor = ''
        ${run "doctor"} > doctor.txt
        calls '[.[] | select(.[0] == "launchctl")] | length == 2'
        calls 'all(.[]; .[0] == "nix" or .[0] == "launchctl")'
        [[ $(<doctor.txt) == *'is not loaded'* ]]
      '';
      diagram = ''
        ${run "diagram"} > diagram.txt
        cmp diagram.txt ${pkgs.writeText "expected.mmd" (render trace)}
        calls '. == [["nix","eval","--no-write-lock-file","--raw",(env.NIX_CONFIG_REPO + "#lib.aspectDiagram")]]'
      '';
      failure = ''
        export FAIL_COMMAND=nix
        reject 7 ${run "build"}
        calls 'length == 1'
      '';
      diffFailure = ''
        export FAIL_COMMAND=diff
        reject 7 ${run "update-all"}
      '';
      invalidArgs = ''
        reject 2 ${run "maintenance"} --unknown
        ${lib.concatMapStringsSep "\n" (n: "reject 2 ${run n} unexpected") (builtins.filter (n: specs.${n}.arguments == "none") (builtins.attrNames specs))}
        export NIX_CONFIG_HOST='bad;host'
        reject 2 ${run "switch"}
        calls 'length == 0'
      '';
      help = ''
        export NIX_CONFIG_REPO=/nonexistent
        ${lib.concatMapStringsSep "\n" (n: ''${run n} --help > help.txt; [[ $(<help.txt) == *'previews unless --apply'* ]]'') (builtins.attrNames specs)}
        calls 'length == 0'
      '';
      missingRepo = ''
        export NIX_CONFIG_REPO=/nonexistent
        reject 2 ${run "maintenance"} --apply
        calls 'length == 0'
      '';
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      benchmark = ''
        ${run "benchmark"}
        calls '[.[] | select(.[1] == "eval") | .[5]] == ["true","true","true","false","false","false"]'
        calls 'length == 7 and all(.[]; .[0] == "nix")'
      '';
    }
    // lib.genAttrs ["update-all" "update-core" "update-tools" "update-homebrew"] (name: ''
      ${run name} > update.txt
      calls '[.[] | select(.[1:3] == ["flake","update"])] == [["nix","flake","update","--flake",env.NIX_CONFIG_REPO] + ${builtins.toJSON specs.${name}.inputs}]'
      calls 'all(.[]; .[0] == "nix" or .[0] == "diff")'
      [[ $(<update.txt) == *'Nothing was activated.'* ]]
      [[ $(<update.txt) == *'+  "revision": "new"'* ]]
    '');
in
  assert lib.assertMsg (failures == []) (builtins.toJSON failures);
    pkgs.runCommand "configuration-command-tests" {
      nativeBuildInputs = [pkgs.bash pkgs.jq pkgs.coreutils pkgs.diffutils];
      passthru = {inherit pureTests failures;};
    } ''
      set -euo pipefail
      export MOCK_BIN=${mock}/bin
      export REPOSITORY="$TMPDIR/repository with spaces"
      mkdir -p "$REPOSITORY/modules"
      touch "$REPOSITORY/flake.nix" "$REPOSITORY/modules/hosts.nix"
      calls() { jq -se "$1" "$CALL_LOG" > /dev/null; }
      reject() {
        expected="$1"; shift
        status=0
        "$@" > rejected.out 2>&1 || status=$?
        if [[ $expected == 1 ]]; then test "$status" -ne 0; else test "$status" -eq "$expected"; fi
      }
      ${lib.concatMapAttrsStringSep "\n" (name: text: ''
          (
            echo 'test: ${name}'
            export NIX_CONFIG_REPO="$REPOSITORY" NIX_CONFIG_HOST=test-host
            export NIX_CONFIG_BREW="$MOCK_BIN/brew"
            export CALL_LOG="$TMPDIR/${name}.jsonl" UPDATED="$TMPDIR/${name}.updated"
            export POLICY=${lib.escapeShellArg (builtins.toJSON (import ../modules/_lib/maintenance.nix))}
            unset FAIL_COMMAND
            : > "$CALL_LOG"
            cd "$REPOSITORY"
            ${text}
          )
        '')
        cases}
      # Build every production-shaped wrapper too (including automatic ShellCheck).
      ${lib.concatMapAttrsStringSep "\n" (name: app: ''${app}/bin/${name} --help > /dev/null'') apps}
      echo '${toString (builtins.length (builtins.attrNames pureTests))} pure tests; ${toString (builtins.length (builtins.attrNames cases))} runtime cases passed' > "$out"
    ''
