# Language runtimes and project tooling. Program modules are preferred over
# raw packages so Home Manager can also manage their environment integration.
_: {
  den.aspects.profiles.development.homeManager =
    { pkgs, ... }:
    let
      javaPackage = pkgs.jdk17;
    in
    {
      programs = {
        awscli.enable = true;
        bun.enable = true;
        cargo.enable = true;
        devenv.enable = true;
        docker-cli.enable = true;
        npm.enable = true;
        uv.enable = true;
        yarn.enable = true;

        java = {
          enable = true;
          package = javaPackage;
        };

        gradle = {
          enable = true;
          package = pkgs.gradle_9-unwrapped;
          settings = {
            "org.gradle.caching" = true;
            "org.gradle.parallel" = true;
            "org.gradle.java.home" = javaPackage;
          };
        };
      };
    };
}
