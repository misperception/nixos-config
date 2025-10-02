{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [mozc];
  };
  services.xserver.xkb = {
    layout = "us,jp";
    variant = "altgr-intl,";
    options = "grp:alt_shift_toggle";
  };
}