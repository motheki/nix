_:{
  den.aspects.motheki.homeManager = { pkgs, ... }: {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;
      settings = {
        theme = "light: Rose Pine Dawn, dark: Rose Pine Moon";
        font-size = 16;
        font-family = "CommitMonoMotheki";
        cursor-style = "bar";
        background-opacity = 1.0;
        background-blur = false;
        window-height = 53;
        window-width = 160;
        window-padding-x = 8;
        window-padding-y = 4;
        window-inherit-working-directory = false;
        tab-inherit-working-directory = false;
        split-inherit-working-directory = false;
        macos-titlebar-style = "transparent";
        auto-update = "download";
        auto-update-channel = "tip";
        #macos-icon = "paper";
        #macos-icon-frame = "beige";
      };
    };
  };
}
