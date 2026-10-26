{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib; 
  let 
    cfg = config.misper.desktop.kde;
  in {
    options.misper.desktop.kde = {
      enable = mkEnableOption "Enable KDE Plasma";
      minimal = mkEnableOption "Minimal packages";
    };
    config = mkIf cfg.enable {
      services.desktopManager.plasma6.enable = mkForce true;
      environment.plasma6.excludePackages = mkIf cfg.minimal (with pkgs.kdePackages; [
        konsole
        elisa
        kwallet
        kcontacts
      ]);
    };
  }; 
}