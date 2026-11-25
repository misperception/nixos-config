{
  flake.homeModules.misper-pc = {
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "demiboy";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        pride_month_disable = false;
      };
    };
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          padding = {
            left = 4;
            right = 4;
          };
          printRemaining = true;
          preserveAspectRatio = true;
        };
        display = {
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "os";
            key = "OS";
          }
          {
            type = "display";
            key = "Display";
            format = "{6} {1}x{2} @ {3}Hz";
          }
          {
            type = "wm";
            key = "Window Manager";
          }
          "separator"
          {
            type = "cpu";
            key = "CPU";
          }
          {
            type = "cpuusage";
            key = "CPU Usage";
          }
          "separator"
          {
            type = "gpu";
            key = "GPU";
          }
          "separator"
          {
            type = "memory";
            key = "RAM";
          }
          "separator"
          {
            type = "disk";
          }
          "separator"
          {
            type = "uptime";
            key = "Uptime";
          }
          "break"
          "break"
          "colors"
        ];
      };
    };
  };
}
