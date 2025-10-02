{ config, ... }:
{
  # Use the GRUB boot loader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    splashMode = "normal";
    backgroundColor = "#1e1e2e";
  };
  # Fix for USB keyboard
  boot.initrd.availableKernelModules = [ "hid_generic" ];
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable quiet boot
  boot.kernelParams = [ "quiet" "splash" ];
}
