# Shared local server identity. No fixed cwd: each client indexes its workspace.
{lib}: let
  tools = ["find_files" "grep" "multi_grep"];
in {
  inherit tools;
  server = {
    command = "/etc/profiles/per-user/motheki/bin/fff-mcp";
    args = ["--no-update-check"];
    enabled = true;
  };
  fxPermissions = lib.genAttrs (map (name: "mcp_fff_${name}") tools) (_: "allow");
  opencodePermissions = lib.genAttrs (map (name: "fff_${name}") tools) (_: "allow");
  context = ''
    For file and text search within the current workspace, prefer the local FFF
    tools instead of built-in search or shell grep/rg/find: find_files for file
    names, grep for contents, and multi_grep for OR searches. In fx, discover the
    configured fff server with capability_search before using its tools.
    Use bare identifiers and narrow file constraints. Do not treat fuzzy matches
    as exact matches. Read known files directly. If FFF is unavailable or a task
    needs ignored files, exact counts, or authorized paths outside its index,
    explain the limitation and use an appropriate scoped fallback. Do not scan
    the entire home directory or filesystem root to work around an index boundary.
  '';
}
