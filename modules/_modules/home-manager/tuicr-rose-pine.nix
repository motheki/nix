# Rosé Pine palettes: https://github.com/rose-pine/rose-pine-palette
# tuicr local theme keys: https://github.com/agavra/tuicr/blob/main/docs/CONFIG.md#local-theme-file-format
let
  mkTheme = p: {
    panel_bg = p.base;
    bg_highlight = p.highlightMed;
    fg_primary = p.text;
    fg_secondary = p.subtle;
    fg_dim = p.muted;

    diff_add = p.pine;
    diff_add_bg = p.highlightLow;
    diff_del = p.love;
    diff_del_bg = p.highlightLow;
    diff_context = p.text;
    diff_hunk_header = p.iris;
    expanded_context_fg = p.muted;
    syntax_add_bg = p.highlightLow;
    syntax_del_bg = p.highlightLow;

    file_added = p.pine;
    file_modified = p.gold;
    file_deleted = p.love;
    file_renamed = p.iris;
    reviewed = p.pine;
    pending = p.gold;

    comment_note = p.iris;
    comment_suggestion = p.foam;
    comment_issue = p.love;
    comment_praise = p.pine;

    border_focused = p.rose;
    border_unfocused = p.overlay;
    status_bar_bg = p.surface;
    cursor_color = p.rose;
    cursor_line_bg = p.highlightLow;
    branch_name = p.iris;
    help_indicator = p.subtle;

    message_info_fg = p.base;
    message_info_bg = p.foam;
    message_warning_fg = p.base;
    message_warning_bg = p.gold;
    message_error_fg = p.base;
    message_error_bg = p.love;
    update_badge_fg = p.base;
    update_badge_bg = p.gold;
    mode_fg = p.base;
    mode_bg = p.rose;
  };
in {
  rose-pine-moon = mkTheme {
    base = "#232136";
    surface = "#2a273f";
    overlay = "#393552";
    muted = "#6e6a86";
    subtle = "#908caa";
    text = "#e0def4";
    love = "#eb6f92";
    gold = "#f6c177";
    rose = "#ea9a97";
    pine = "#3e8fb0";
    foam = "#9ccfd8";
    iris = "#c4a7e7";
    highlightLow = "#2a283e";
    highlightMed = "#44415a";
  };
  rose-pine-dawn = mkTheme {
    base = "#faf4ed";
    surface = "#fffaf3";
    overlay = "#f2e9e1";
    muted = "#9893a5";
    subtle = "#797593";
    text = "#575279";
    love = "#b4637a";
    gold = "#ea9d34";
    rose = "#d7827e";
    pine = "#286983";
    foam = "#56949f";
    iris = "#907aa9";
    highlightLow = "#f4ede8";
    highlightMed = "#dfdad9";
  };
}
