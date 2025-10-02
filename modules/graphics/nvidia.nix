{ config, pkgs, ... }:
{
  # Enable OpenGL.
  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-ocl
      intel-media-driver
      intel-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  # NVIDIA driver configuration.
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Enable modesetting.
    modesetting.enable = true;

    # Disable power management.
    powerManagement = {
      enable = false;
      finegrained = false;
    };

    # Disable open-source kernel module.
    open = false;

    # Enable settings menu.
    nvidiaSettings = true;

    # Declare version of the package
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}