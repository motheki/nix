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
      env-vars = [];
      option-as-alt = "Left";
      ignore-selection-foreground-color = false;
      editor = "nvim";
      hide-cursor-when-typing = true;
      confirm-before-quit = false;
      navigation = {
        mode = "Plain";
        use-current-path = true;
      };
      colors = {
        background = "#1a1a1a";
        foreground = "#d4d4d4";
        cursor = "#d4d4d4";
        selection = "#4d4d4d";
        black = "#1a1a1a";
        red = "#d78787";
        green = "#afd787";
        yellow = "#d7d787";
        blue = "#87afd7";
        magenta = "#d7afd7";
        cyan = "#87d7d7";
        white = "#d4d4d4";
        bright-black = "#4d4d4d";
        bright-red = "#ffafaf";
        bright-green = "#d7ffaf";
        bright-yellow = "#ffffaf";
        bright-blue = "#afd7ff";
        bright-magenta = "#ffafff";
        bright-cyan = "#afffff";
        bright-white = "#ffffff";
      };

      window = {
        decorations = "Buttonless";
        width = 1000;
        height = 600;
        mode = "Windowed";
        foreground-opacity = 0.8;
        background-opacity = 0.3;
        blur = true;
      };

      renderer = {
        performance = "High";
        backend = "Metal";
        disable-renderer-when-unfocused = true;
      };

      fonts = {
        size = 14.0;
        extras = [];
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
          style = "Medium";
        };
        bold-italic = {
          family = "CommitMonoMotheki";
          weight = 400;
          style = "Medium Italic";
        };
      };
      developer = {
        enable-fps-counter = false;
        log-level = "OFF";
      };
    };
  };
}
