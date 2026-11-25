{
  catppuccin.swaync.enable = false;
  services.swaync = {
    enable = true;
    style = ./style.css;
    settings = {
      ignore-gtk-theme = true;
      positionX = "center";
      control-center-positionX = "right";
      notification-window-width = 400;
      notification-window-height = 200;
      notification-2fa-action = false;
      layer-shell-cover-screen = false;
      notification-inline-replies = true;
      widgets = [
        "title"
        "mpris"
        "inhibitors"
        "notifications"
      ];
      widget-config = {
        mpris = {
          autohide = true;
        };
      };
    };
  };
}
