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
    virtualisation.oci-containers.containters.sonarr = {
      serviceName = "sonarr";
      image = "ghcr.io/hotio/sonarr";
      extraOptions = mkIf root.hostMode [ "--network=host" ];
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