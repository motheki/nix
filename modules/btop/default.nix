{...}: {
  programs.btop = {
    enable = true;
    themes = {
      rose-pine = ''
        # Main background, empty for terminal default, need to be empty if you want transparent background
        theme[main_bg]="#191724"
        # Base

        # Main text color
        theme[main_fg]="#e0def4"
        # Text

        # Title color for boxes
        theme[title]="#908caa"
        # Subtle

        # Highlight color for keyboard shortcuts
        theme[hi_fg]="#e0def4"
        # Text

        # Background color of selected item in processes box
        theme[selected_bg]="#524f67"
        # HL High

        # Foreground color of selected item in processes box
        theme[selected_fg]="#f6c177"
        # Gold

        # Color of inactive/disabled text
        theme[inactive_fg]="#403d52"
        # HL Med

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
        theme[graph_text]="#9ccfd8"
        # Foam

        # Background color of the percentage meters
        theme[meter_bg]="#9ccfd8"
        # Foam

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
        theme[proc_misc]="#c4a7e7"
        # Iris

        # Cpu box outline color
        theme[cpu_box]="#ebbcba"
        # Rose

        # Memory/disks box outline color
        theme[mem_box]="#31748f"
        # Pine

        # Net up/down box outline color
        theme[net_box]="#c4a7e7"
        # Iris

        # Processes box outline color
        theme[proc_box]="#eb6f92"
        # Love

        # Box divider line and small boxes line color
        theme[div_line]="#6e6a86"
        # Muted

        # Temperature graph colors
        theme[temp_start]="#ebbcba"
        # Rose
        theme[temp_mid]="#f6c177"
        # Gold
        theme[temp_end]="#eb6f92"
        # Love

        # CPU graph colors
        theme[cpu_start]="#f6c177"
        # Gold
        theme[cpu_mid]="#ebbcba"
        # Rose
        theme[cpu_end]="#eb6f92"
        # Love

        # Mem/Disk free meter
        # all love
        theme[free_start]="#eb6f92"
        theme[free_mid]="#eb6f92"
        theme[free_end]="#eb6f92"

        # Mem/Disk cached meter
        # all iris
        theme[cached_start]="#c4a7e7"
        theme[cached_mid]="#c4a7e7"
        theme[cached_end]="#c4a7e7"

        # Mem/Disk available meter
        # all pine
        theme[available_start]="#31748f"
        theme[available_mid]="#31748f"
        theme[available_end]="#31748f"

        # Mem/Disk used meter
        # all rose
        theme[used_start]="#ebbcba"
        theme[used_mid]="#ebbcba"
        theme[used_end]="#ebbcba"

        # Download graph colors
        # Pine for start, foam for the rest
        theme[download_start]="#31748f"
        theme[download_mid]="#9ccfd8"
        theme[download_end]="#9ccfd8"

        # Upload graph colors
        theme[upload_start]="#ebbcba"
        # Rose for start
        theme[upload_mid]="#eb6f92"
        # Love for mid and end
        theme[upload_end]="#eb6f92"

        # Process box color gradient for threads, mem and cpu usage
        theme[process_start]="#31748f"
        # Pine
        theme[process_mid]="#9ccfd8"
        # Foam for mid and end
        theme[process_end]="#9ccfd8"
      '';
      rose-pine-moon = ''
        # Main background, empty for terminal default, need to be empty if you want transparent background
        theme[main_bg]="#232136"

        # Main text color
        theme[main_fg]="#e0def4"

        # Title color for boxes
        theme[title]="#908caa"

        # Highlight color for keyboard shortcuts
        theme[hi_fg]="#e0def4"

        # Background color of selected item in processes box
        theme[selected_bg]="#56526e"

        # Foreground color of selected item in processes box
        theme[selected_fg]="#f6c177"

        # Color of inactive/disabled text
        theme[inactive_fg]="#44415a"

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
        theme[graph_text]="#9ccfd8"

        # Background color of the percentage meters
        theme[meter_bg]="#9ccfd8"

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
        theme[proc_misc]="#c4a7e7"

        # Cpu box outline color
        theme[cpu_box]="#ea9a97"

        # Memory/disks box outline color
        theme[mem_box]="#3e8fb0"

        # Net up/down box outline color
        theme[net_box]="#c4a7e7"

        # Processes box outline color
        theme[proc_box]="#eb6f92"

        # Box divider line and small boxes line color
        theme[div_line]="#6e6a86"

        # Temperature graph colors
        theme[temp_start]="#ea9a97"
        theme[temp_mid]="#f6c177"
        theme[temp_end]="#eb6f92"

        # CPU graph colors
        theme[cpu_start]="#f6c177"
        theme[cpu_mid]="#ea9a97"
        theme[cpu_end]="#eb6f92"

        # Mem/Disk free meter
        theme[free_start]="#eb6f92"
        theme[free_mid]="#eb6f92"
        theme[free_end]="#eb6f92"

        # Mem/Disk cached meter
        theme[cached_start]="#c4a7e7"
        theme[cached_mid]="#c4a7e7"
        theme[cached_end]="#c4a7e7"

        # Mem/Disk available meter
        theme[available_start]="#3e8fb0"
        theme[available_mid]="#3e8fb0"
        theme[available_end]="#3e8fb0"

        # Mem/Disk used meter
        theme[used_start]="#ea9a97"
        theme[used_mid]="#ea9a97"
        theme[used_end]="#ea9a97"

        # Download graph colors
        theme[download_start]="#3e8fb0"
        theme[download_mid]="#9ccfd8"
        theme[download_end]="#9ccfd8"

        # Upload graph colors
        theme[upload_start]="#ea9a97"
        theme[upload_mid]="#eb6f92"
        theme[upload_end]="#eb6f92"

        # Process box color gradient for threads, mem and cpu usage
        theme[process_start]="#3e8fb0"
        theme[process_mid]="#9ccfd8"
        theme[process_end]="#9ccfd8"
      '';
      rose-pine-dawn = ''
        # Main background, empty for terminal default, need to be empty if you want transparent background
        theme[main_bg]="#faf4ed"

        # Main text color
        theme[main_fg]="#575279"

        # Title color for boxes
        theme[title]="#797593"

        # Highlight color for keyboard shortcuts
        theme[hi_fg]="#575279"

        # Background color of selected item in processes box
        theme[selected_bg]="#cecacd"

        # Foreground color of selected item in processes box
        theme[selected_fg]="#ea9d34"

        # Color of inactive/disabled text
        theme[inactive_fg]="#dfdad9"

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
        theme[graph_text]="#56949f"

        # Background color of the percentage meters
        theme[meter_bg]="#56949f"

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
        theme[proc_misc]="#907aa9"

        # Cpu box outline color
        theme[cpu_box]="#d7827e"

        # Memory/disks box outline color
        theme[mem_box]="#286983"

        # Net up/down box outline color
        theme[net_box]="#907aa9"

        # Processes box outline color
        theme[proc_box]="#b4637a"

        # Box divider line and small boxes line color
        theme[div_line]="#9893a5"

        # Temperature graph colors
        theme[temp_start]="#d7827e"
        theme[temp_mid]="#ea9d34"
        theme[temp_end]="#b4637a"

        # CPU graph colors
        theme[cpu_start]="#ea9d34"
        theme[cpu_mid]="#d7827e"
        theme[cpu_end]="#b4637a"

        # Mem/Disk free meter
        theme[free_start]="#b4637a"
        theme[free_mid]="#b4637a"
        theme[free_end]="#b4637a"

        # Mem/Disk cached meter
        theme[cached_start]="#907aa9"
        theme[cached_mid]="#907aa9"
        theme[cached_end]="#907aa9"

        # Mem/Disk available meter
        theme[available_start]="#286983"
        theme[available_mid]="#286983"
        theme[available_end]="#286983"

        # Mem/Disk used meter
        theme[used_start]="#d7827e"
        theme[used_mid]="#d7827e"
        theme[used_end]="#d7827e"

        # Download graph colors
        theme[download_start]="#286983"
        theme[download_mid]="#56949f"
        theme[download_end]="#56949f"

        # Upload graph colors
        theme[upload_start]="#d7827e"
        theme[upload_mid]="#b4637a"
        theme[upload_end]="#b4637a"

        # Process box color gradient for threads, mem and cpu usage
        theme[process_start]="#286983"
        theme[process_mid]="#56949f"
        theme[process_end]="#56949f"
      '';
    };
    settings = {
      color_theme = "rose-pine-moo";
      theme_background = false;
    };
  };
}
