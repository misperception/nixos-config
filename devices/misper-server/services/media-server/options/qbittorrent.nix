{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.qbittorrent;
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
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.qbittorrent.service = {
      container_name = "qbittorrent";
      image = "lscr.io/linuxserver/qbittorrent:latest";
      restart = "unless-stopped";
      network_mode = mkIf root.hostMode "host";
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORT = cfg.ports.webui;
        TORRENTING_PORT = cfg.ports.torrenting;
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/qbittorrent:/config"
        "${root.dataDir}/downloads:/data/downloads"
      ];
      ports = [
        "${toString cfg.ports.webui}:${toString cfg.ports.webui}"
        "${toString cfg.ports.torrenting}:${toString cfg.ports.torrenting}"
        "${toString cfg.ports.torrenting}:${toString cfg.ports.torrenting}/udp"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.ports.torrenting cfg.ports.webui ];
    networking.firewall.allowedUDPPorts = mkIf cfg.openFirewall [ cfg.ports.torrenting ];
  };
}