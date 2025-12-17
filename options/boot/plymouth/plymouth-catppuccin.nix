{ config, lib, ... }: with lib; let 
  parent = config.misper.boot.plymouth;
  cfg = parent.catppuccin;
in {
  options.misper.boot.plymouth.catppuccin = {
    enable = mkEnableOption "Catppuccin theme for Plymouth";
  };
  config = mkIf (parent.enable && cfg.enable) {
    catppuccin.plymouth.enable = mkForce true;
  };
}