# Repository tooling and opt-in language environments, all from the same pin.
{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nixd
          alejandra
          statix
          deadnix
          shellcheck
          shfmt
          python3
          jq
          nh
          hyperfine
        ];
      };
      mobile = pkgs.mkShellNoCC {
        packages = [pkgs.jdk17 (pkgs.gradle_9-unwrapped.override {java = pkgs.jdk17;})];
        JAVA_HOME = "${pkgs.jdk17.home}";
        GRADLE_OPTS = "-Dorg.gradle.caching=true -Dorg.gradle.parallel=true -Dorg.gradle.workers.max=4";
      };
      systems = pkgs.mkShell {
        packages = with pkgs; [rustc cargo rust-analyzer go gopls zig zls];
      };
    };
  };
}
