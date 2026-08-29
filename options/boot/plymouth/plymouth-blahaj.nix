{ config, lib, pkgs, ... }: with lib; let   
  catppuccin-blahaj-theme = pkgs.plymouth-blahaj-theme.overrideAttrs (old: {
    src = pkgs.fetchurl {
      url = "https://github.com/misperception/catppuccin-plymouth-blahaj/releases/download/v.1.0.0/blahaj.tar.gz";
      sha256 = "sha256-lQumew3X+fu7501HBz08uecqxrF88M1XIIYvAi9FbeM=";
    };
  });
  parent = config.misper.boot.plymouth;
  cfg = parent.blahaj;
in {
  options.misper.boot.plymouth.blahaj = {
    enable = mkEnableOption "Enable Blåhaj animation for Plymouth";
  };
  config = mkIf (parent.enable && cfg.enable) {
    boot.plymouth = {
      theme = mkForce "blahaj";
      themePackages = mkForce [ catppuccin-blahaj-theme ];
    };
  };
}
