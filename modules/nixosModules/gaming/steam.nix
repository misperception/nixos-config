{ pkgs, config, lib, ... }: with lib; let
  cfg = config.misper.gaming.steam;
in {
  options.misper.gaming.steam = {
    enable = mkEnableOption "Steam";
  };
  config = mkIf cfg.enable {
    programs.steam = {
      enable = mkForce true;
      extest.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}