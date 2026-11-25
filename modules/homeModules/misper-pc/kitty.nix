{
  flake.homeModules.misper-pc = {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 13;
      };
      settings = {
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_bar_align = "center";
        tab_bar_background = "none";
        wayland_titlebar_color = "background";
        background_opacity = "0.7";
        background_blur = 30;
        cursor = "#cdd6f4";
        cursor_text_color = "#313244";
        cursor_shape = "beam";
        cursor_trail = 50;
        cursor_trail_color = "#cdd6f4";
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = 2;
        pixel_scroll = true;
        window_padding_width = "8 16";
      };
    };
  };
}
