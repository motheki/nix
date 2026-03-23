{ ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "rose-pine-dawn";
      theme_background = false;
    };

    themes = {
      rose-pine-moon = ''
        theme[main_bg]="#1f1d2e"
        theme[main_fg]="#e0def4"
        theme[title]="#e0def4"
        theme[hi_fg]="#eb6f92"
        theme[selected_bg]="#26233a"
        theme[selected_fg]="#e0def4"
        theme[inactive_fg]="#6e6a86"
        theme[graph_text]="#908caa"
        theme[meter_bg]="#2a273f"
        theme[proc_misc]="#9ccfd8"
        theme[cpu_box]="#c4a7e7"
        theme[mem_box]="#eb6f92"
        theme[net_box]="#f6c177"
        theme[proc_box]="#31748f"
        theme[div_line]="#2a273f"
        theme[temp_start]="#eb6f92"
        theme[temp_mid]="#f6c177"
        theme[temp_end]="#9ccfd8"
        theme[cpu_start]="#9ccfd8"
        theme[cpu_mid]="#c4a7e7"
        theme[cpu_end]="#eb6f92"
        theme[free_start]="#31748f"
        theme[free_mid]="#9ccfd8"
        theme[free_end]="#c4a7e7"
        theme[cached_start]="#f6c177"
        theme[cached_mid]="#f6c177"
        theme[cached_end]="#f6c177"
        theme[available_start]="#6e6a86"
        theme[available_mid]="#908caa"
        theme[available_end]="#e0def4"
        theme[used_start]="#eb6f92"
        theme[used_mid]="#ea9a97"
        theme[used_end]="#f6c177"
        theme[download_start]="#9ccfd8"
        theme[download_mid]="#c4a7e7"
        theme[download_end]="#eb6f92"
        theme[upload_start]="#f6c177"
        theme[upload_mid]="#ea9a97"
        theme[upload_end]="#eb6f92"
        theme[process_start]="#9ccfd8"
        theme[process_mid]="#c4a7e7"
        theme[process_end]="#eb6f92"
      '';

      rose-pine-dawn = ''
        theme[main_bg]="#faf4ed"
        theme[main_fg]="#575279"
        theme[title]="#575279"
        theme[hi_fg]="#d7827e"
        theme[selected_bg]="#f2e9e1"
        theme[selected_fg]="#575279"
        theme[inactive_fg]="#9893a5"
        theme[graph_text]="#6e6a86"
        theme[meter_bg]="#f2e9e1"
        theme[proc_misc]="#56949f"
        theme[cpu_box]="#907aa9"
        theme[mem_box]="#d7827e"
        theme[net_box]="#ea9d34"
        theme[proc_box]="#286983"
        theme[div_line]="#f2e9e1"
        theme[temp_start]="#d7827e"
        theme[temp_mid]="#ea9d34"
        theme[temp_end]="#56949f"
        theme[cpu_start]="#56949f"
        theme[cpu_mid]="#907aa9"
        theme[cpu_end]="#d7827e"
        theme[free_start]="#286983"
        theme[free_mid]="#56949f"
        theme[free_end]="#907aa9"
        theme[cached_start]="#ea9d34"
        theme[cached_mid]="#ea9d34"
        theme[cached_end]="#ea9d34"
        theme[available_start]="#9893a5"
        theme[available_mid]="#6e6a86"
        theme[available_end]="#575279"
        theme[used_start]="#d7827e"
        theme[used_mid]="#ea9d34"
        theme[used_end]="#f6c177"
        theme[download_start]="#56949f"
        theme[download_mid]="#907aa9"
        theme[download_end]="#d7827e"
        theme[upload_start]="#ea9d34"
        theme[upload_mid]="#d7827e"
        theme[upload_end]="#ea9d34"
        theme[process_start]="#56949f"
        theme[process_mid]="#907aa9"
        theme[process_end]="#d7827e"
      '';
    };
  };
}

