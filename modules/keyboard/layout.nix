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
    layout = "us,jp";
    variant = "altgr-intl,";
    options = "grp:alt_shift_toggle";
  };
}
