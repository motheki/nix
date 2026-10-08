# Exercise the reusable module independently of the personal host inventory.
{
  inputs,
  pkgs,
}: let
  evaluate = settings:
    (inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ../modules/_modules/home-manager/fx.nix
        {
          home = {
            username = "fx-test";
            homeDirectory = "/tmp/fx-test";
            stateVersion = "26.11";
          };
          programs.fx.enable = true;
        }
        settings
      ];
    }).config;
  integrated = evaluate {
    programs = {
      fx = {
        enableMcpIntegration = true;
        mcpServers.override = {
          type = "stdio";
          command = "/test/local-server";
        };
      };
      mcp = {
        enable = true;
        servers = {
          fff = {
            command = pkgs.lib.getExe pkgs.fff-mcp;
            args = ["--no-update-check"];
            enabled = true;
          };
          override = {
            url = "https://example.invalid/mcp";
            headers."X-Old-Transport" = "obsolete";
          };
          remote.url = "https://example.invalid/remote";
          disabled = {
            command = "/test/disabled-server";
            disabled = true;
          };
          environment = {
            command = "/test/env-server";
            env.TEST_VALUE = "literal";
          };
        };
      };
    };
  };
  standalone = evaluate {
    programs.fx.mcpServers.local = {
      type = "stdio";
      command = "/test/standalone-server";
    };
  };
  unconfigured = evaluate {};
in
  assert !(unconfigured.home.file ? ".fx/mcp.json");
    pkgs.runCommand "fx-mcp-config" {nativeBuildInputs = [pkgs.jq];} ''
      jq -e --arg command ${pkgs.lib.escapeShellArg (pkgs.lib.getExe pkgs.fff-mcp)} '
        .mcp.fff == {type: "stdio", command: $command, args: ["--no-update-check"], enabled: true} and
        .mcp.override == {type: "stdio", command: "/test/local-server"} and
        .mcp.remote == {type: "http", url: "https://example.invalid/remote"} and
        .mcp.disabled == {type: "stdio", command: "/test/disabled-server", enabled: false} and
        .mcp.environment == {type: "stdio", command: "/test/env-server", env: {TEST_VALUE: "literal"}}
      ' ${integrated.home.file.".fx/mcp.json".source} > /dev/null
      jq -e '.mcp == {local: {type: "stdio", command: "/test/standalone-server"}}' \
        ${standalone.home.file.".fx/mcp.json".source} > /dev/null
      touch "$out"
    ''
