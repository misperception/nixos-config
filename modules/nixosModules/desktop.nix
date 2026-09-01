{
  flake.nixosModules.customOptions = { config, lib, ... }: with lib;
  let 
    cfg = config.misper.desktop;
  in {
    options.misper.desktop = {
      enable = mkEnableOption "Desktop session";
      xwayland = mkEnableOption "XWayland";
    };
    config = mkIf cfg.enable {
      services.xserver.enable = mkForce true;
      programs.xwayland.enable = cfg.xwayland;
    };
  };
}