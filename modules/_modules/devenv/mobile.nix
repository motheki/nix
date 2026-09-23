# Project-scoped JVM toolchain; vendor-managed SDKs remain outside the store.
{pkgs, ...}: {
  name = "nix-mobile";
  stdenv = pkgs.stdenvNoCC;
  apple.sdk = null;
  packages = [pkgs.jdk17 (pkgs.gradle_9-unwrapped.override {java = pkgs.jdk17;})];
  env = {
    JAVA_HOME = "${pkgs.jdk17.home}";
    GRADLE_OPTS = "-Dorg.gradle.caching=true -Dorg.gradle.parallel=true -Dorg.gradle.workers.max=4";
  };
}
