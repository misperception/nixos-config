{
  lib,
  pkgs,
  ...
}: {
  home.file.".wallpapers".source = ./wallpapers;
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi";
      input = {
        "type:keyboard" = {
          xkb_layout = "us,jp";
          xkb_variant = "altgr-intl";
        };
      };
      fonts = {
        names = ["JetBrainsMono Nerd Font"];
        size = 11.0;
      };
      keybindings = lib.mergeAttrsList [
        # Workspaces
        (
          lib.mergeAttrsList (map (
            n: let
              workspace = toString n;
            in {
              "${modifier}+${workspace}" = "workspace ${workspace}";
              "${modifier}+Shift+${workspace}" = "move container to workspace ${workspace}, workspace ${workspace}";
            }
          ) [1 2 3 4 5 6 7 8 9 0])
        )
        {
          "Alt+tab" = "workspace next_on_output";
          "Alt+Shift+tab" = "workspace prev_on_output";
        }
        # General keybindings
        {
          # App launching
          "${modifier}+T" = "exec ${terminal}";
          "${modifier}+E" = "exec nautilus";
          "${modifier}+space" = "exec pgrep wofi && killall .wofi-wrapped || wofi --show drun,run";
          # System commands
          "${modifier}+Q" = "kill";
          "Alt+F4" = "kill";
          # Sway windowing
          "${modifier}+Shift+F" = "floating toggle";
          "Alt+Return" = "fullscreen";
          "F11" = "fullscreen";
          "${modifier}+s" = "scratchpad show";
          "${modifier}+Shift+s" = "move scratchpad";
          "--whole-window ${modifier}+button2" = "move scratchpad";
          # Sway commands
          "Ctrl+${modifier}+R" = "exec swaymsg reload";
          # Notification panel
          "${modifier}+Shift+P" = "exec swaync-client -t";
          # Audio control
          "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
          "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
          "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
          "${modifier}+XF86AudioMute" = "exec wpctl inspect @DEFAULT_SINK@ | grep HDMI && wpctl set-default 48 || wpctl set-default 56";
          # Capslock and brightness
          "--release Caps_Lock" = "exec swayosd-client --caps-lock";
          "XF86MonBrightnessUp" = "swayosd-client --brightness raise";
          "XF86MonBrightnessDown" = "swayosd-client --brightness lower";
          # Logout menu
          "${modifier}+Shift+L" = "exec wlogout";
          # Screenshotting
          "Print" = "exec pgrep slurp && killall slurp || grimshot --notify copy anything";
        }
      ];
      window = {
        border = 3;
        titlebar = false;
      };
      floating = {
        border = 3;
        titlebar = false;
        criteria = [
          {title = "Picture-in-Picture";}
          {title = "KeePassXC";}
          {app_id = "kitty";}
          {app_id = "org.gnome.Nautilus";}
          {app_id = "org.gnome.TextEditor";}
          {app_id = "org.gnome.FileRoller";}
        ];
      };
      startup = [
        {command = "exec vesktop";}
        {command = "exec steam";}
        {command = "systemctl --user restart awww swayosd";}
      ];
      gaps = {
        outer = 20;
        inner = 8;
      };
      colors = {
        background = "#1e1e2e";
        focused = {
          background = "#1e1e2e";
          border = "#cba6f7";
          childBorder = "#cba6f7";
          indicator = "#cba6f7";
          text = "#cdd6f4";
        };
        focusedInactive = {
          background = "#181825";
          border = "#6c7086";
          childBorder = "#6c7086";
          indicator = "#6c7086";
          text = "#bac2de";
        };
        unfocused = {
          background = "#11111b";
          border = "#313244";
          childBorder = "#313244";
          indicator = "#313244";
          text = "#a6adc8";
        };
        urgent = {
          background = "#1e1e2e";
          border = "#f9e2af";
          childBorder = "#f9e2af";
          indicator = "#f9e2af";
          text = "#cdd6f4";
        };
      };
      bars = [{command = "waybar";}];
      output = {
        DP-1 = {
          mode = "1920x1080@200.000Hz";
          adaptive_sync = "on";
          render_bit_depth = "10";
        };
      };
    };
    extraConfig = ''
                  corner_radius 6
                  shadows enable
                  blur enable
                  default_dim_inactive 0.15
                  animation_duration_ms 100

                  for_window [class=".*"] opacity 0.85

                  for_window [app_id="floorp"] opacity 1
                  for_window [app_id=org.gnome.Nautilus] border pixel 3
                  for_window [app_id=org.gnome.TextEditor] border pixel 3
      	        for_window [app_id=org.gnome.FileRoller] border pixel 3
    '';
    wrapperFeatures = {
      gtk = true;
    };
  };
}
