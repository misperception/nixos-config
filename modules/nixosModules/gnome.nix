{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib; let
    parent = config.misper.desktop;
    cfg = parent.gnome;
  in {
    options.misper.desktop.gnome = {
      enable = mkEnableOption "GNOME Desktop Environment";
      extensions = mkOption {
        type = types.listOf types.package;
        default = with pkgs.gnomeExtensions; [ appindicator ];
      };
      minimal = mkEnableOption "excluding most default packages";
      nautilus.preview = mkEnableOption "file previews in file manager";
      enableKittySupport = mkEnableOption "Support for the Kitty terminal emulator";
    };
    config = mkIf cfg.enable {
      services.desktopManager.gnome.enable = mkForce true;
      environment.systemPackages = cfg.extensions;

      environment.gnome.excludePackages = mkIf cfg.minimal (
        with pkgs; [
          decibels # Gnome Audio Player
          epiphany # GNOME Web
          geary # GNOME Mail
          gnome-console
          gnome-contacts
          gnome-maps
          gnome-terminal
          gnome-tour
          gnome-weather
          seahorse # GNOME Passwords & Keys
          showtime # GNOME Video Player
          snapshot # GNOME Camera
          totem # GNOME Videos
          xterm
        ]
      );
      services.xserver.excludePackages = mkIf cfg.enableKittySupport [ pkgs.xterm ];
      # Enable Kitty for .desktop entries
      xdg.terminal-exec = mkIf cfg.enableKittySupport {
        enable = true;
        settings = {
          default = [
            "kitty.desktop"
          ];
        };
      };

      # Configure Nautilus (GNOME Files)
      programs.nautilus-open-any-terminal = mkIf cfg.enableKittySupport {
        enable = true;
        terminal = "kitty";
      };
      services.gnome.sushi.enable = cfg.nautilus.preview;
    };
  };
}