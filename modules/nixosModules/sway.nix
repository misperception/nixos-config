{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib;
  let
    parent = config.misper.desktop;
    cfg = parent.sway;
  in {
    options.misper.desktop.sway = {
      enable = mkEnableOption "Sway Window Manager";
      package = mkOption {
        type = types.package;
        default = pkgs.sway;
      };
    };
    config = mkIf cfg.enable {
      programs.sway = {
        enable = true;
        package = cfg.package;
        extraPackages = [];
      };
      environment.variables.SWAY_UNSUPPORTED_GPU = mkIf config.misper.hardware.graphics.nvidia.enable ( mkForce 1 );

      # Enable PAM for swaylock
      security.pam.services.swaylock = {
        enable = true;
        allowNullPassword = true;
      };
      # Enable libinput (for waybar capslock detection)
      services.libinput.enable = true;
    };
  };
}