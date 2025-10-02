{ pkgs, ... }:
{ 
  # Add sway to the session list (configuration overriden by home-manager)
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraOptions = [ "--unsupported-gpu" ];
    extraPackages = [];
  };
  # Enable PAM for swaylock
  security.pam.services.swaylock = {
    enable = true;
    allowNullPassword = true;
  };
  # Enable libinput (for waybar)
  services.libinput.enable = true;
}
