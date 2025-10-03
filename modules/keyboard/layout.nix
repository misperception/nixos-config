{ pkgs, ... }:
{
  # IME config.
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
}
