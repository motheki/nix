{...}: {
  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = "Rosé Pine";
      helix_mode = true;
      buffer_font_family = "CommitMonoMotheki";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
  };
}
