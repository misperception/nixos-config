{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      width = "25%";
      single_click = true;
      dynamic_lines = true;
      insensitive = true;
      hide_scroll = true;
      allow_markup = true;
      exec_search = true;
      prompt = "search...";
      key_expand = "Tab";
    };
    style = ./style.css;
  };
}
