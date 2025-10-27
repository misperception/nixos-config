{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;

  # Manage extensions
  environment.systemPackages = with pkgs.gnomeExtensions; [ 
    appindicator # System tray icons
    system-monitor # Resource usage
    removable-drive-menu
    user-themes
    rounded-window-corners-reborn
  ];

  # Exclude default applications
  environment.gnome.excludePackages = (
    with pkgs; [
      gnome-tour
      snapshot # GNOME Camera
      gnome-console
      epiphany # GNOME Web
      xterm
      geary # GNOME Mail
      gnome-contacts
      gnome-weather
      gnome-maps
      totem # GNOME Videos
      gnome-terminal
      seahorse # GNOME Passwords & Keys
    ]
  );
  # Disable XTerm
  services.xserver.excludePackages = with pkgs; [ xterm ];
  # Enable Kitty for .desktop entries
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };

  # Configure Nautilus (GNOME Files)
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };
  services.gnome.sushi.enable = true;
}
