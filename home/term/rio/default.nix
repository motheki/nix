{...}: {
  programs.rio = {
    enable = true;
    settings = {
      blinking-cursor = true;
      line-height = 1.0;
      padding-x = 10.0;
      cursor = {
        shape = "beam";
        blinking = true;
      };
      scroll-multiplier = 1.0;
      env-vars = [];
      option-as-alt = "Left";
      ignore-selection-foreground-color = false;
      hide-cursor-when-typing = true;
      confirm-before-quit = false;
      navigation = {
        mode = "Plain";
        use-current-path = true;
      };
      window = {
        decorations = "Buttonless";
        width = 1000;
        height = 600;
        mode = "Windowed";
        opacity = 1;
        blur = false;
      };
      adaptive-theme = {
        light = "ayu_light";
        dark = "ayu";
      };
      renderer = {
        performance = "High";
        backend = "Metal";
        disable-renderer-when-unfocused = true;
      };

      use-fork = false;

      fonts = {
        size = 14.0;
        extras = [];
        regular = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Normal";
        };
        italic = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Italic";
        };
        bold = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Normal";
        };
        bold-italic = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Italic";
        };
      };
      developer = {
        enable-fps-counter = false;
        log-level = "OFF";
      };
    };
  };
}
