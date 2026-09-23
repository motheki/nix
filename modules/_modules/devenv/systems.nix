# Reusable systems-language environment, independent of the user's login PATH.
{pkgs, ...}: {
  name = "nix-systems";
  packages = with pkgs; [rustc cargo rust-analyzer go gopls zig zls];
}
