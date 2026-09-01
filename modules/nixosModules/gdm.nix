{
  flake.nixosModules.customOptions = { config, lib, ... }: with lib;
  let
    cfg = config.misper.boot.gdm;
  in {
    options.misper.boot.gdm = {
      enable = mkEnableOption "Enable the GNOME Display Manager";
    };
    config = mkIf cfg.enable {
      services.displayManager.gdm.enable = mkForce true;
    };
  };
}