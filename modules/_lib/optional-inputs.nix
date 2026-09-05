# One loading policy shared by consumers and the dependency manifest. Avoid
# blanket `unified`; use upstream pins only after comparing cache/build results.
inputs: {
  llm-agents = inputs.omniflake.flakes."github:numtide/llm-agents.nix";
  nix-homebrew = inputs.omniflake.lib.load "nix-homebrew" {
    inherit (inputs) brew-src;
  };
}
