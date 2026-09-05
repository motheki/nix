{den, ...}: {
  den.aspects.features.editor-navigation = {
    includes = [den.aspects.features.editor-core];
    homeManager.programs.nixvim.plugins.fff = {
      enable = true;
      settings = {
        key_bindings = {
          close = ["<Esc>" "<C-c>"];
          move_down = ["<Down>" "<C-n>"];
          move_up = ["<Up>" "<C-p>"];
          open_split = "<C-s>";
          open_tab = "<C-t>";
          open_vsplit = "<C-v>";
          select_file = "<CR>";
        };
        layout = {
          height = 0.8;
          width = 0.8;
          prompt_position = "top";
          preview_position = "right";
          preview_size = 0.5;
          border = "rounded";
          flex = {
            size = 130;
            wrap = "top";
          };
          min_list_height = 10;
          show_scrollbar = true;
          path_shorten_strategy = "middle_number";
          anchor = "center";
        };
        max_results = 100;
      };
    };
  };
}
