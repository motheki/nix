{...}: {
  nix.settings = {
    extra-experimental-features = [nix-command flakes];
  };
}
