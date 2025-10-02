{pkgs, ...}:
{
  # Enable QMK
  hardware.keyboard.qmk.enable = true;

  # Enable VIA
  environment.systemPackages = with pkgs; [ via ];
  services.udev.packages = [ pkgs.via ];
}
