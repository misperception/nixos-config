{
  flake.homeModules.misper-laptop = {
    services.glance = {
      enable = true;
      settings = {
        theme = {
          background-color = "240 21 15";
          contrast-multiplier = 1.2;
          primary-color = "217 92 83";
          positive-color = "115 54 76";
          negative-color = "347 70 65";
        };

        branding = {
          logo-url = "https://pbs.twimg.com/profile_images/1826743978542112769/4s5W2xP6_400x400.jpg";
          hide-footer = true;
        };

        server = {
          port = 5995;
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
                    hour-format = "24h";
                    location = "Getafe";
                  }
                  {type = "calendar";}
                ];
              }

              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    search-engine = "duckduckgo";
                    bangs = [
                      {
                        title = "Youtube";
                        shortcut = "!yt";
                        url = "https://www.youtube.com/results?search_query={QUERY}";
                      }
                      {
                        title = "Subreddit Search";
                        shortcut = "r/";
                        url = "https://www.reddit.com/r/{QUERY}";
                      }
                      {
                        title = "GitHub Project";
                        shortcut = "!gh";
                        url = "https://github.com/{QUERY}";
                      }
                      {
                        title = "URL";
                        shortcut = ". ";
                        url = "{QUERY}";
                      }
                    ];
                  }
                  {
                    type = "twitch-channels";
                    channels = [
                      "5ro4"
                      "ralseikebabs"
                      "RanguStreamer"
                      "Guinxu"
                      "EricRod"
                    ];
                    sort-by = "live";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
