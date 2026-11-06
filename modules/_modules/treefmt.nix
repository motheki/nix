# Shared by nix fmt and the native devenv shell.
{
  projectRootFile = "flake.nix";
  programs = {
    alejandra.enable = true;
    deadnix.enable = true;
    mdformat.enable = true;
    statix.enable = true;
  };
}
