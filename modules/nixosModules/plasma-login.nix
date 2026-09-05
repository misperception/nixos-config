{
  flake.nixosModules.customOptions = { config, lib, ... }: with lib;
  let
    cfg = config.misper.boot.plasma-lm;
  in {
    options.misper.boot.plasma-lm = {
      enable = mkEnableOption "Enable the KDE Plasma Login Manager";
    };
    config = mkIf cfg.enable {
      services.displayManager.plasma-login-manager.enable = mkForce true;
    };
  };
}