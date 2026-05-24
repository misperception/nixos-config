let
  defaultOptions = {
    enable = true;
    openFirewall = true;
  }; 
in {
  imports = [
    ./options
  ];
  media-server = {
    enable = true;
    hostMode = true;
    timezone = "Europe/Madrid";
    configDir = "/media-server/config";
    dataDir = "/media-server/data";
    qbittorrent = defaultOptions // { qui.enable = true; };
    prowlarr = defaultOptions;
    sonarr = defaultOptions;
    radarr = defaultOptions;
    seerr = defaultOptions;
    jellyfin = defaultOptions;
    maintainerr = defaultOptions;
  };
}