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
      nvidiaSupport = mkEnableOption "support for NVIDIA proprietary drivers";
    };
    config = mkIf cfg.enable {
      programs.sway = {
        enable = true;
        package = cfg.package;
        extraPackages = [];
        extraOptions = mkIf cfg.nvidiaSupport [ "--unsupported-gpu" ];
      };

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