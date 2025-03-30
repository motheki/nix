{
  ezModules,
  lib,
  inputs,
  ...
}: {
  imports = lib.attrValues {
    inherit
      (ezModules)
      shell
      ssh
      git
      helix
      ;
  };
}
