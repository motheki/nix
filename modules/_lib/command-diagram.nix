# Pure equivalent of the original trace renderer: stable SHA-256 IDs and ordering.
{lib}: entries: let
  validString = value: builtins.isString value;
  normalize = entry:
    if !builtins.isAttrs entry
    then throw "Invalid Den trace: expected an entry attribute set"
    else let
      name =
        if (entry.path or null) == null || (entry.path or "") == ""
        then entry.name or null
        else entry.path;
      parent = entry.parent or null;
    in
      if !validString name || !(parent == null || validString parent)
      then throw "Invalid Den trace: expected string name/path and optional string parent"
      else {inherit name parent;};
  normalized =
    if builtins.isList entries
    then map normalize entries
    else throw "Invalid Den trace: expected a list";
  hasParent = entry: entry.parent != null && entry.parent != "" && entry.parent != entry.name;
  names = lib.sort builtins.lessThan (lib.unique (lib.concatMap (entry: [entry.name] ++ lib.optional (hasParent entry) entry.parent) normalized));
  edges = lib.sort (a: b:
    if a.parent == b.parent
    then a.name < b.name
    else a.parent < b.parent)
  (lib.unique (builtins.filter hasParent normalized));
  identifier = name: "n" + builtins.substring 0 16 (builtins.hashString "sha256" name);
  escape = builtins.replaceStrings ["&" "<" ">" "\"" "'" "\n"] ["&amp;" "&lt;" "&gt;" "&quot;" "&#x27;" " "];
in
  lib.concatStringsSep "\n" (["flowchart TD"]
    ++ map (name: "  ${identifier name}[\"${escape name}\"]") names
    ++ map (edge: "  ${identifier edge.parent} --> ${identifier edge.name}") edges)
  + "\n"
