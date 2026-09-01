{
  flake.nixosModules.customOptions = { config, lib, pkgs, ... }: with lib; let
    tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
    xsessions = "${config.services.displayManager.sessionData.desktops}/share/xsessions";
    wayland-sessions = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
    cfg = config.misper.boot.tuigreet;
  in {
    options.misper.boot.tuigreet = {
      enable = mkEnableOption "Enable the TUIGreet display manager";
    };
    config = mkIf cfg.enable {
      services.greetd = {
        enable = mkForce true;
        settings = {
          default_session = {
            command = "${tuigreet} --time --user-menu --asterisks -r --remember-session --sessions ${xsessions}:${wayland-sessions}";
          };
          user = "greeter";
        };
        useTextGreeter = true;
      };
    };
  };
}