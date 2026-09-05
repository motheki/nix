# Opt-in only. Bootstrap the upstream cached image before customizing its VM.
{
  den.aspects.features.linux-builder.darwin.nix = {
    linux-builder = {
      enable = true;
      systems = ["aarch64-linux"];
      ephemeral = false;
    };
    settings.builders-use-substitutes = true;
  };
}
