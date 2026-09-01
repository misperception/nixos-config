{ pkgs, config, lib, ...}: with lib; let
  cfg = config.misper.keyboard.qmk;
in {
  options.misper.keyboard.qmk = {
    enable = mkEnableOption "QMK";
    via = mkEnableOption "VIA";
  };
  config = mkIf cfg.enable {
    hardware.keyboard.qmk.enable = mkForce true;
    environment.systemPackages = mkIf cfg.via [ pkgs.via ];
    services.udev.packages = mkIf cfg.via [ pkgs.via ];
  };
}
