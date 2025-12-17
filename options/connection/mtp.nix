{ config, lib, ... }: with lib; let
  cfg = config.misper.connection.mtp;
in {
  options.misper.connection.mtp = {
    enable = mkEnableOption "MTP";
  };
  config = mkIf cfg.enable {
    services.gvfs.enable = mkForce true;
  };
}