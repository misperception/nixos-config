{
  flake.nixosModules.customOptions = { lib, config, pkgs, ... }: with lib; let
    cfg = config.misper.desktop.niri;
  in {
    options.misper.desktop.niri = {
      enable = mkEnableOption "Enable niri";
    };
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        nautilus # File selector
        rofi
        waybar
        file-roller # Archive decompressor
        loupe # Image viewer
        vlc
      ];
      programs.niri = {
        enable = true;
        useNautilus = true;
      };
    };
  };
}
