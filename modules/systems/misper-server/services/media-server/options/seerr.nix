{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.seerr;
in {
  options.media-server.seerr = {
    enable = mkEnableOption "Enable Seerr, a companion app for Sonarr and Radarr that allows users to request media";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 5055;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.seerr.service = {
      container_name = "seerr";
      image = "ghcr.io/hotio/seerr";
      restart = "unless-stopped";
      network_mode = mkIf root.hostMode "host";
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/seerr:/config"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}