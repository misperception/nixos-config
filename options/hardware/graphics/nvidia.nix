{ config, lib, pkgs, ... }: with lib; let
  parent = config.misper.hardware.graphics;
  cfg = parent.nvidia; 
in {
  options.misper.hardware.graphics.nvidia = {
    enable = mkEnableOption "NVIDIA proprietary drivers";
    enable32Bit = mkEnableOption "support for 32 bit applications";
    driver = mkOption {
      type = types.package;
      default = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    powerManagement = mkEnableOption "NVIDIA power management";
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-ocl
        intel-media-driver
        intel-vaapi-driver
      ];
      extraPackages32 = mkIf cfg.enable32Bit ( with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
      ]);
    };
    services.xserver.videoDrivers = mkForce [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = mkForce true;
      # Disable power management.
      powerManagement = {
        enable = cfg.powerManagement;
        finegrained = cfg.powerManagement;
      };
      open = false;
      nvidiaSettings = true;

      # Declare version of the package
      package = cfg.driver;
    };
  };
}