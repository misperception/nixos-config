{ config, lib, ... }: with lib; let
  cfg = config.misper.boot.grub;
in {
  options.misper.boot.grub = {
    enable = mkEnableOption "Enable GRUB";
  };
  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = mkForce true;
      efiSupport = true;
      device = lib.mkDefault "nodev";
      useOSProber = true;
      splashMode = "normal";
      backgroundColor = lib.mkDefault "#1e1e2e";
    };
    boot.kernelParams = lib.mkDefault [ "quiet" "splash" ];
  };
}