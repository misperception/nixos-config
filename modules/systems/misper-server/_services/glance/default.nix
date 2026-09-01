{ config, ... }:
{
  age.secrets = {
    glance.file = ../../_secrets/glance.age;
  };
  services.glance = {
    enable = true;
    openFirewall = true;
    environmentFile = config.age.secrets.glance.path;
    settings = {
      server.host = "0.0.0.0";
      server.port = 5995;
      theme = {
        background-color = "240 21 15";
        contrast-multiplier = 1.2;
        primary-color = "217 92 83";
        positive-color = "115 54 76";
        negative-color = "347 70 65";
        presets = {
          catppuccin-latte = {
            light = true;
            background-color = "220 23 95";
            contrast-multiplier = 1.0;
            primary-color = "220 91 54";
            positive-color = "109 58 40";
            negative-color = "347 87 44";
          };
          catppuccin-macchiato = {
            background-color = "232 23 18";
            contrast-multiplier = 1.2;
            primary-color = "220 83 75";
            positive-color = "105 48 72";
            negative-color = "351 74 73";
          };
        };
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "Europe/Madrid";
                      label = "Madrid";
                    }
                    {
                      timezone = "Europe/London";
                      label = "London";
                    }
                    {
                      timezone = "America/New_York";
                      label = "New York";
                    }
                  ];
                }
                {
                  type = "weather";
                  units = "metric";
                  hour-format = "24h";
                  location = "\${LOCATION}";
                }
                {
                  type = "calendar";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "duckduckgo";
                }
                {
                  type = "twitch-channels";
                  channels = [
                    "AlvaMajo"
                    "asrielkebabs"
                    "turosu19"
                    "MossyTheMush"
                    "Vicfis"
                    "RanguStreamer"
                    "Guinxu"
                    "EricRod"
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "Server";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "docker-containers";
                }
              ];
            }
            {
              size = "small";
              widgets = let
                widget = import ./beszel-stats.nix;
              in [ widget ];
            }
          ];
        }
      ];
    };
  };
}