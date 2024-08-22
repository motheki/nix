{ ... }:

{
  programs.rio = {
    enable = true;
    settings = {
      blinking-cursor = true;
      line-height = 1.0;
      padding-x = 10.0;
      cursor = "|";
      scroll-multiplier = 1.0;
      env-vars = [ ];
      option-as-alt = "Left";
      ignore-selection-foreground-color = false;
      hide-cursor-when-typing = true;
      confirm-before-quit = false;
      navigation = {
        mode = "Plain";
        use-current-path = true;
      };
      adaptive-theme = {
        light = "ayu_light";
        dark = "ayu";
      };
      window = {
        decorations = "Buttonless";
        width = 1000;
        height = 600;
        mode = "Windowed";
        opacity = 0.5;
        blur = true;
      };

      renderer = {
        performance = "High";
        backend = "Metal";
        disable-renderer-when-unfocused = true;
      };

      use-fork = true;

      fonts = {
        size = 14.0;
        extras = [ ];
        regular = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Regular";
        };
        italic = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Regular Italic";
        };
        bold = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Bold";
        };
        bold-italic = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Bold Italic";
        };
      };
      developer = {
        enable-fps-counter = false;
        log-level = "OFF";
      };
    };
  };
}
