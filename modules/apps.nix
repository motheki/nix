_: {
  den.aspects.motheki.homeManager = {pkgs, ...}: {
    fonts.fontconfig.enable = true;

    services.ollama.enable = false;

    programs = {
      btop = {
        enable = false;
        settings = {
          color_theme = "rose-pine-dawn";
          theme_background = false;
          vim_keys = true;
        };
        themes = {
          nord = ''
            theme[main_bg]="#2E3440"
            theme[main_fg]="#D8DEE9"
            theme[title]="#8FBCBB"
            theme[hi_fg]="#5E81AC"
            theme[selected_bg]="#4C566A"
            theme[selected_fg]="#ECEFF4"
            theme[inactive_fg]="#4C566A"
            theme[proc_misc]="#5E81AC"
            theme[cpu_box]="#4C566A"
            theme[mem_box]="#4C566A"
            theme[net_box]="#4C566A"
            theme[proc_box]="#4C566A"
            theme[div_line]="#4C566A"
            theme[temp_start]="#81A1C1"
            theme[temp_mid]="#88C0D0"
            theme[temp_end]="#ECEFF4"
            theme[cpu_start]="#81A1C1"
            theme[cpu_mid]="#88C0D0"
            theme[cpu_end]="#ECEFF4"
            theme[free_start]="#81A1C1"
            theme[free_mid]="#88C0D0"
            theme[free_end]="#ECEFF4"
            theme[cached_start]="#81A1C1"
            theme[cached_mid]="#88C0D0"
            theme[cached_end]="#ECEFF4"
            theme[available_start]="#81A1C1"
            theme[available_mid]="#88C0D0"
            theme[available_end]="#ECEFF4"
            theme[used_start]="#81A1C1"
            theme[used_mid]="#88C0D0"
            theme[used_end]="#ECEFF4"
            theme[download_start]="#81A1C1"
            theme[download_mid]="#88C0D0"
            theme[download_end]="#ECEFF4"
            theme[upload_start]="#81A1C1"
            theme[upload_mid]="#88C0D0"
            theme[upload_end]="#ECEFF4"
          '';
          rose-pine-dawn = ''
            theme[main_bg]="#faf4ed"
            theme[main_fg]="#575279"
            theme[title]="#797593"
            theme[hi_fg]="#575279"
            theme[selected_bg]="#cecacd"
            theme[selected_fg]="#ea9d34"
            theme[inactive_fg]="#dfdad9"
            theme[graph_text]="#56949f"
            theme[meter_bg]="#56949f"
            theme[proc_misc]="#907aa9"
            theme[cpu_box]="#d7827e"
            theme[mem_box]="#286983"
            theme[net_box]="#907aa9"
            theme[proc_box]="#b4637a"
            theme[div_line]="#9893a5"
            theme[temp_start]="#d7827e"
            theme[temp_mid]="#ea9d34"
            theme[temp_end]="#b4637a"
            theme[cpu_start]="#ea9d34"
            theme[cpu_mid]="#d7827e"
            theme[cpu_end]="#b4637a"
            theme[free_start]="#b4637a"
            theme[free_mid]="#b4637a"
            theme[free_end]="#b4637a"
            theme[cached_start]="#907aa9"
            theme[cached_mid]="#907aa9"
            theme[cached_end]="#907aa9"
            theme[available_start]="#286983"
            theme[available_mid]="#286983"
            theme[available_end]="#286983"
            theme[used_start]="#d7827e"
            theme[used_mid]="#d7827e"
            theme[used_end]="#d7827e"
            theme[download_start]="#286983"
            theme[download_mid]="#56949f"
            theme[download_end]="#56949f"
            theme[upload_start]="#d7827e"
            theme[upload_mid]="#b4637a"
            theme[upload_end]="#b4637a"
            theme[process_start]="#286983"
            theme[process_mid]="#56949f"
            theme[process_end]="#56949f"
          '';
          rose-pine-moon = ''
            theme[main_bg]="#232136"
            theme[main_fg]="#e0def4"
            theme[title]="#908caa"
            theme[hi_fg]="#e0def4"
            theme[selected_bg]="#56526e"
            theme[selected_fg]="#f6c177"
            theme[inactive_fg]="#44415a"
            theme[graph_text]="#9ccfd8"
            theme[meter_bg]="#9ccfd8"
            theme[proc_misc]="#c4a7e7"
            theme[cpu_box]="#ea9a97"
            theme[mem_box]="#3e8fb0"
            theme[net_box]="#c4a7e7"
            theme[proc_box]="#eb6f92"
            theme[div_line]="#6e6a86"
            theme[temp_start]="#ea9a97"
            theme[temp_mid]="#f6c177"
            theme[temp_end]="#eb6f92"
            theme[cpu_start]="#f6c177"
            theme[cpu_mid]="#ea9a97"
            theme[cpu_end]="#eb6f92"
            theme[free_start]="#eb6f92"
            theme[free_mid]="#eb6f92"
            theme[free_end]="#eb6f92"
            theme[cached_start]="#c4a7e7"
            theme[cached_mid]="#c4a7e7"
            theme[cached_end]="#c4a7e7"
            theme[available_start]="#3e8fb0"
            theme[available_mid]="#3e8fb0"
            theme[available_end]="#3e8fb0"
            theme[used_start]="#ea9a97"
            theme[used_mid]="#ea9a97"
            theme[used_end]="#ea9a97"
            theme[download_start]="#3e8fb0"
            theme[download_mid]="#9ccfd8"
            theme[download_end]="#9ccfd8"
            theme[upload_start]="#ea9a97"
            theme[upload_mid]="#eb6f92"
            theme[upload_end]="#eb6f92"
            theme[process_start]="#3e8fb0"
            theme[process_mid]="#9ccfd8"
            theme[process_end]="#9ccfd8"
          '';
        };
      };

      discord.enable = false;

      ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          theme = "light: Rose Pine Dawn, dark: Rose Pine Moon";
          font-size = 16;
          font-family = "CommitMonoMotheki";
          cursor-style = "bar";
          background-opacity = 0.85;
          background-blur = true;
          window-height = 53;
          window-width = 160;
          window-padding-x = 8;
          window-padding-y = 4;
          window-inherit-working-directory = true;
          tab-inherit-working-directory = true;
          split-inherit-working-directory = true;
          macos-titlebar-style = "transparent";
          auto-update = "download";
          auto-update-channel = "tip";
          #macos-icon = "glass";
          #macos-icon-frame = "beige";
        };
      };

      opencode = {
        enable = true;
        tui.theme = "system";
        settings = {
          autoupdate = true;
          autoshare = false;
          lsp = true;
        };
      };

      codex.enable = false;

      streamlink = {
        enable = false;
        settings.player = "~/.nix-profile/bin/iina";
      };

      yt-dlp = {
        enable = true;
        settings = {
          paths = "/Volumes/mothekis_drive/videos/youtube";
          ffmpeg-location = "/etc/profiles/per-user/motheki/bin/ffmpeg";
          embed-thumbnail = true;
          embed-metadata = true;
          sponsorblock-remove = "selfpromo,interaction,sponsor";
          progress = true;
          quiet = true;
          check-all-formats = true;
          output = "%(title)s.%(ext)s";
        };
      };
    };
  };
}
