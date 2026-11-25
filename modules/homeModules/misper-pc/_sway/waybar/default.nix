{pkgs, ...}: {
  services.playerctld.enable = true;
  catppuccin.waybar.enable = false;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 15;
        margin = "20 20 0 20";

        modules-left = ["image#user" "sway/workspaces" "sway/window"];
        modules-center = ["clock"];
        modules-right = ["group/stats" "mpris" "group/misc" "tray"];

        "group/stats" = {
          orientation = "inherit";
          modules = ["cpu" "memory"];
        };

        "group/misc" = {
          orientation = "inherit";
          modules = ["wireplumber"];
        };

        "image#user" = {
          path = "/home/misper/.face";
          size = 24;
          interval = 5;
        };

        "sway/workspaces" = {
          format = "{name}";
        };

        "keyboard-state" = {
          capslock = true;
          format = {
            capslock = "{icon}";
          };
          format-icons = {
            locked = "󰪛 ";
            unlocked = "";
          };
        };

        "sway/window" = {
          icon = true;
          icon-size = 16;
          tooltip = false;
          max-length = 30;
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "{:%a. %d %b}";
        };

        "cpu" = {
          interval = 2;
          format = "  {usage}%";
        };

        "memory" = {
          interval = 2;
          format = "  {percentage}%";
        };

        "wireplumber" = {
          format = "{icon} {volume}%";
          format-muted = "  0%";
          format-icons = [" " " " " "];
        };

        "tray" = {
          spacing = 10;
        };

        "mpris" = let
          format-base = "{player_icon}  <b>{artist}</b> {title}";
        in {
          format = format-base + " {position} / {length}";
          format-paused = format-base + " {status_icon}";
          player-icons = {
            default = "";
            spotify = "";
          };
          status-icons.paused = "";
          ignored-players = ["firefox"];
          interval = 1;
        };
      };
    };
    style = ./style.css;
  };
}
