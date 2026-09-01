{ self, ... }:
{
  flake.nixosModules.customOptions = { config, lib, pkgs, ... }: with lib; 
  let
    parent = config.misper.boot.plymouth;
    cfg = parent.blahaj;
  in {
    options.misper.boot.plymouth.blahaj = {
      enable = mkEnableOption "Enable Blåhaj animation for Plymouth";
    };
    config = mkIf (parent.enable && cfg.enable) {
      boot.plymouth = {
        theme = mkForce "blahaj";
        themePackages = mkForce [ self.packages.${pkgs.system}.catppuccin-plymouth-blahaj ];
      };
    };
  };
}