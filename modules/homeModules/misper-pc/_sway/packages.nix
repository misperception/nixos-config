{pkgs, ...}: {
  home.packages = with pkgs; [
    eww
    wl-clipboard
    sway-contrib.grimshot
    pavucontrol
    libnotify
    wdisplays
  ];
  services.awww.enable = true;
}
