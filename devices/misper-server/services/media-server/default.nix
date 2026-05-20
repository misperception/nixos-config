{
  imports = [
    ./options
  ];
  media-server = {
    enable = true;
    hostMode = true;
    timezone = "Europe/Madrid";
    configDir = "/media-server/config";
    dataDir = "/media-server/data";
    qbittorrent = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    seerr = {
      enable = true;
      openFirewall = true;
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    maintainerr = {
      enable = true;
      openFirewall = true;
    };
  };
}