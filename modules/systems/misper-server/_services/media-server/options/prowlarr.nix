{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.prowlarr;
in {
  options.media-server.prowlarr = {
    enable = mkEnableOption "Enable Prowlarr, an open source indexer manager for Usenet and Torrent";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 9696;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.prowlarr = {
      serviceName = "prowlarr";
      image = "ghcr.io/hotio/prowlarr";
      extraOptions = mkIf root.hostMode [ "--network=host" ];
      environment = {
        PUID = root.uid;
        PGID = root.gid;
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/prowlarr:/config"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}