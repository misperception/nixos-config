{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.jellyfin;
in {
  options.media-server.jellyfin = {
    enable = mkEnableOption "Enable Jellyfin, an open source server-side media player";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 8096;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.jellyfin.service = {
      container_name = "jellyfin";
      image = "ghcr.io/hotio/jellyfin";
      restart = "unless-stopped";
      network_mode = mkIf root.hostMode "host";
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/jellyfin:/config"
        "${root.dataDir}:/data"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}