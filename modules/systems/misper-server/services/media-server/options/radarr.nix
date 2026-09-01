{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.radarr;
in {
  options.media-server.radarr = {
    enable = mkEnableOption "Enable Radarr, an automatic download manager for movies";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 7878;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.radarr.service = {
      container_name = "radarr";
      image = "ghcr.io/hotio/radarr";
      restart = "unless-stopped";
      network_mode = mkIf root.hostMode "host";
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/radarr:/config"
        "${root.dataDir}:/data"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}