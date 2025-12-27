{ config, lib, ... }: with lib; let
  cfg = config.misper.boot.plymouth;
in {
  options.misper.boot.plymouth = {
    enable = mkEnableOption "Enable the Plymouth splash screen";
  };
  imports = [
    ./plymouth-blahaj.nix
    ./plymouth-catppuccin.nix
  ];
  config = mkIf cfg.enable {
    boot.plymouth.enable = mkForce true;
  };
}