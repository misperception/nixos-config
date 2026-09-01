{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.qbittorrent;
  common-config = {
    PUID = root.uid;
    PGID = root.gid;
    TZ = root.timezone;
  };
in {
  options.media-server.qbittorrent = {
    enable = mkEnableOption "Enable Qbittorrent, a lightweight torrent client.";
    openFirewall = mkEnableOption "Open ports automatically";
    ports.torrenting = mkOption {
      type = types.int;
      default = 9201;
    };
    ports.webui = mkOption {
      type = types.int;
      default = 9200;
    };
    qui.enable = mkEnableOption "Enable Qui, a dashboard and manager for remote torrent clients";
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services = {
      qbittorrent.service = {
        container_name = "qbittorrent";
        image = "lscr.io/linuxserver/qbittorrent:latest";
        restart = "unless-stopped";
        network_mode = mkIf root.hostMode "host";
        environment = common-config // {
          WEBUI_PORT = (if !cfg.qui.enable then cfg.ports.webui else 8055);
          TORRENTING_PORT = cfg.ports.torrenting;
        };
        volumes = [
          "${root.configDir}/qbittorrent:/config"
          "${root.dataDir}/downloads:/data/downloads"
        ];
        ports = [
          (if !cfg.qui.enable then "${toString cfg.ports.webui}:${toString cfg.ports.webui}" else "8055:8055")
          "${toString cfg.ports.torrenting}:${toString cfg.ports.torrenting}"
          "${toString cfg.ports.torrenting}:${toString cfg.ports.torrenting}/udp"
        ];
      };
      qui.service = mkIf cfg.qui.enable {
        container_name = "qui";
        image = "ghcr.io/hotio/qui";
        restart = "unless-stopped";
        network_mode = mkIf root.hostMode "host";
        environment = common-config // {
          WEBUI_PORTS = "${toString cfg.ports.webui}/tcp";
        };
        volumes = [ 
          "${root.configDir}/qui:/config"
          "${root.dataDir}:/data" ];
        ports = [ "${toString cfg.ports.webui}:${toString cfg.ports.webui}" ];
      };
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.ports.torrenting cfg.ports.webui ];
    networking.firewall.allowedUDPPorts = mkIf cfg.openFirewall [ cfg.ports.torrenting ];
  };
}