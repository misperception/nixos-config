{ config, pkgs, ... }: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  xsessions = "${config.services.displayManager.sessionData.desktops}/share/xsessions";
  wayland-sessions = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
in {
    # Enable greetd
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
	  command = "${tuigreet} --time --user-menu --asterisks -r --remember-session --sessions ${xsessions}:${wayland-sessions}";
	};
	user = "greeter";
      };
      useTextGreeter = true;
    };
}
