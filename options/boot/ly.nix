{ config, lib, ... }: with lib; let
  cfg = config.misper.boot.ly;
in {
  options.misper.boot.ly = {
    enable = mkEnableOption "Enable the Ly display manager";
  };
  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = mkForce true;
      settings = {
        animation = lib.mkDefault "matrix";
        bg = lib.mkDefault "0x001E1E2e";
        bigclock = lib.mkDefault "en";
        border_fg = lib.mkDefault "0x00CDD6F4";
        cmatrix_fg = lib.mkDefault "0x0089B4FA";
        cmatrix_head_col = lib.mkDefault "0x00B4BEFE";
      };
    };
  };
}