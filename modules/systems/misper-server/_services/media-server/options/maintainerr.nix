{ config, lib, ... }: with lib; let
  root = config.media-server;
  cfg = root.maintainerr;
in {
  options.media-server.maintainerr = {
    enable = mkEnableOption "Enable Maintainerr, a stale media manager for *arr apps";
    openFirewall = mkEnableOption "Open port automatically";
    port = mkOption {
      type = types.int;
      default = 6246;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.arion.projects.media-server.settings.services.maintainerr.service = {
      container_name = "maintainerr";
      image = "ghcr.io/maintainerr/maintainerr:latest";
      restart = "unless-stopped";
      user = "${toString root.uid}:${toString root.gid}";
      network_mode = mkIf root.hostMode "host";
      environment = {
        WEBUI_PORTS = "${toString cfg.port}/tcp";
        TZ = root.timezone;
      };
      volumes = [
        "${root.configDir}/maintainerr:/opt/data"
      ];
      ports = [
        "${toString cfg.port}:${toString cfg.port}"
      ];
    };
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}