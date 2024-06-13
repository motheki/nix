{ ... }:


{
  programs.wezterm = {
    enable = true;
    extraConfig = 
    ''
      function get_appearance()
        if wezterm.gui then
          return wezterm.gui.get_appearance()
        end
        return 'Dark'
      end
      function scheme_for_appearance(appearance)
        if appearance:find("Dark", 1, true) then
          return "ayu"
        else
          return "ayu-light"
        end
      end
      function opacity_for_appearance(appearance)
        if appearance:find("Dark") then
          return 1.00
        else
          return 1.00
        end
      end
      function macos_blur_for_appearance(appearance)
        if appearance:find("Dark") then
          return 0
        else
          return 0
        end
      end
      keybinds = {
        {
          key = "d",
          mods = "OPT",
          action = wezterm.action.SplitPane({
            direction = "Right",
            size = {
              Percent = 50,
            },
          }),
        },
        {
          key = "f",
          mods = "OPT",
          action = wezterm.action.SplitPane({
            direction = "Down",
            size = {
              Percent = 50,
            },
          }),
        },
      }
      appearance = get_appearance()
      scheme = scheme_for_appearance(appearance)
      opacity = opacity_for_appearance(appearance)
      macos_opacity = macos_blur_for_appearance(appearance)
      gpus = wezterm.gui.enumerate_gpus()
      return {
        color_scheme = scheme,
        window_background_opacity = opacity,
        macos_window_background_blur = macos_opacity,
        enable_tab_bar = false,
        term = "wezterm",
        default_cursor_style = "BlinkingBar",
        native_macos_fullscreen_mode = true,
        webgpu_power_preference = "HighPerformance",
        webgpu_preferred_adapter = gpus[1],
        front_end = "WebGpu",
        prefer_to_spawn_tabs = true,
        use_resize_increments = true,
        use_ime = true,
        show_tabs_in_tab_bar = false,
        automatically_reload_config = true,
        freetype_load_target = "Light",
        freetype_interpreter_version = 40,
        freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
        check_for_updates = true,
        check_for_updates_interval_seconds = 86400,
        audible_bell = "Disabled",
        window_decorations = "RESIZE",
        keys = keybinds,
        font = wezterm.font_with_fallback {
          { family = 'CommitMonoMotheki', weight = 'Regular' },
          'Apple Color Emoji',
        },
        exit_behavior_messaging = "None",
        window_close_confirmation = "NeverPrompt",
      }
    '';
  };
}
