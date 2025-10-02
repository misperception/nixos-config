{ pkgs, ... }:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable Avahi.
  services.avahi = {
    enable = true;
    openFirewall = true;
  };
}