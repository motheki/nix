# Reusable systems-language environment, independent of the user's login PATH.
{pkgs, ...}: {
  name = "nix-systems";
  # Restore compiler and SDK support when layered onto the repository tooling.
  inherit (pkgs) stdenv;
  apple.sdk =
    if pkgs.stdenv.hostPlatform.isDarwin
    then pkgs.apple-sdk
    else null;
  packages = with pkgs; [rustc cargo rust-analyzer go gopls zig zls];
}
