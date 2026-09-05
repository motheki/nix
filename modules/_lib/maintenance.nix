# Shared by launchd, the manual command, and policy checks. Never shell-split.
{
  retentionArgs = ["--keep" "5" "--keep-since" "14d"];
  # Project environment roots are intentionally retained for fast direnv reuse.
  preserveRootsArgs = ["--no-gcroots" "--no-direnv"];
  systemProfile = "/nix/var/nix/profiles/system";
}
