# flake-parts owns the shell outputs; devenv provides activation and tasks.
{inputs, ...}: {
  imports = [inputs.devenv.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devenv.shells = {
      default = {
        name = "nix-config";
        stdenv = pkgs.stdenvNoCC;
        apple.sdk = null;
        # One treefmt configuration, used both here and by `nix fmt`/checks.
        # Do not enable devenv's treefmt task: it formats on shell entry.
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nixd
          alejandra
          statix
          deadnix
          jq
          nh
          hyperfine
          direnv
        ];
        env.NIX_CONFIG_SHELL = "nix-config";
      };
      mobile = {
        name = "nix-mobile";
        stdenv = pkgs.stdenvNoCC;
        apple.sdk = null;
        packages = [pkgs.jdk17 (pkgs.gradle_9-unwrapped.override {java = pkgs.jdk17;})];
        env = {
          JAVA_HOME = "${pkgs.jdk17.home}";
          GRADLE_OPTS = "-Dorg.gradle.caching=true -Dorg.gradle.parallel=true -Dorg.gradle.workers.max=4";
        };
      };
      systems = {
        name = "nix-systems";
        packages = with pkgs; [rustc cargo rust-analyzer go gopls zig zls];
      };
    };
  };
}
