{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.sonarr;
in {
  options.media-server.sonarr = {
    enable = mkEnableOption "Enable Sonarr, an automatic download manager for TV Shows";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 8989;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.sonarr.service = {
      container_name = "sonarr";
      image = "ghcr.io/hotio/sonarr";
      restart = "unless-stopped";
      network_mode = mkIf root.hostMode "host";
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/sonarr:/config"
        "${root.dataDir}:/data"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}