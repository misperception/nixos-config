{ pkgs, ... }:
{ 
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    extraPackages = [];
    extraOptions = [ "--unsupported-gpu" ];
  };

  # Enable PAM for swaylock
  security.pam.services.swaylock = {
    enable = true;
    allowNullPassword = true;
  };
  # Enable libinput (for waybar)
  services.libinput.enable = true;
}
