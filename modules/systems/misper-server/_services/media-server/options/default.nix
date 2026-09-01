{ config, lib, ... }: with lib; let
  cfg = config.media-server;
in {
  options.media-server = {
    enable = mkEnableOption "Enable media server options";
    hostMode = mkEnableOption "Have containers use the host's network";
    uid = mkOption {
      type = types.int;
      default = 7777;
    };
    gid = mkOption {
      type = types.int;
      default = 7777;
    };
    timezone = mkOption {
      type = types.str;
    };
    configDir = mkOption {
      type = types.str;
    };
    dataDir = mkOption {
      type = types.str;
    };
  };
  imports = [
    ./prowlarr.nix
    ./sonarr.nix
    ./radarr.nix
    ./seerr.nix
    ./jellyfin.nix
    ./maintainerr.nix
    ./qbittorrent.nix
  ];
  config = mkIf cfg.enable {
    users.users.media-server = {
      enable = true;
      isSystemUser = true;
      uid = cfg.uid;
      group = "media-server";
      extraGroups = [ "docker" ];
    };
    users.groups.media-server.gid = cfg.gid;
  };
}