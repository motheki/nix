# flake-parts owns the shell outputs; devenv provides activation and tasks.
{inputs, ...}: {
  imports = [inputs.devenv.flakeModule];
}
