{
  home.file.".config/wlogout/icons".source = ./icons;
  catppuccin.wlogout.enable = false;
  programs.wlogout = {
    enable = true;
    style = ./style.css;
  };
}
