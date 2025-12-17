{ pkgs, config, lib, ... }: with lib; let
  cfg = config.misper.virtualization.docker;
in {
  options.misper.virtualization.docker = {
    enable = mkEnableOption "Docker";
    rootless = mkEnableOption "Rootless Docker mode";
  };
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = mkForce true;
      enableOnBoot = mkDefault true;
      rootless = mkIf cfg.rootless {
        enable = mkForce true;
        setSocketVariable = true;
      };
      daemon.settings = {
        data-root = "/home/misper/Docker";
        userland-proxy = false;
      };
    };
    users.extraGroups.docker.members = mkIf cfg.enable [ "misper" ];
  };
}
