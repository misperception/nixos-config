{
  flake.nixosModules.customConfig ={ pkgs, config, lib, ... }: with lib;
  let
    cfg = config.misper.keyboard;
  in {
    options.misper.keyboard = {
      layout = mkOption {
        type = types.str;
        default = "us";
      };
      layoutVariant = mkOption {
        type = types.str;
        default = "";
      };
      ime = mkEnableOption "IME support";
    };
    config = {
      i18n.inputMethod = mkIf cfg.ime {
        enable = mkForce true;
        type = "fcitx5";
        fcitx5.waylandFrontend = true;
        fcitx5.addons = with pkgs; [
          fcitx5-gtk
          fcitx5-mozc
        ];
      };
      services.xserver.xkb = {
        layout = mkForce cfg.layout;
        variant = mkForce cfg.layoutVariant;
      };
    };
  };
}
