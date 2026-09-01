{
  flake.nixosModules.customOptions = { config, lib, pkgs, ... }: with lib;
  let
    cfg = config.misper.base;
  in {
    options.misper.base = {
      appimage = mkEnableOption "AppImage";
      defaultPackages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          wget
          killall
          busybox
          git
          fzf
          icu
          wineWow64Packages.base
        ];
      };
      firstVersion = mkOption {
        type = types.str;
      };
      flatpak = mkEnableOption "Flatpak";
      fonts = mkOption {
        type = types.listOf types.package;
        default = [ pkgs.nerd-fonts.jetbrains-mono ];
      };
      garbageCollection = mkEnableOption "Garbage Collector";
      hostname = mkOption {
        type = types.str;
      };
      timezone = mkOption {
        type = types.str;
        default = "Europe/Madrid";
      };
      zsh = mkEnableOption "ZSH as default shell";
    };

    config = {
      misper = {
        boot.grub.enable = true;
        connection = {
          bluetooth.enable = true;
          mtp.enable = true;
        };
      };

      system.stateVersion = mkForce cfg.firstVersion;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      networking.hostName = mkForce cfg.hostname;
      nix.gc = mkIf cfg.garbageCollection {
        automatic = true;
        dates = "weekly";
        options = "--delete-old";
        persistent = true;
      };
      nix.optimise = {
        automatic = true;
        dates = [ "20:00" "11:00" ];
      };

      networking.networkmanager.enable = true;
      networking.firewall.enable = true;

      time.timeZone = cfg.timezone;
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";     
        useXkbConfig = true;
      };

      security.polkit.enable = true;
      services.flatpak.enable = mkForce cfg.flatpak;
      programs.appimage = mkIf cfg.appimage {
        enable = mkForce true;
        binfmt = mkForce true;
      };
      environment.systemPackages = cfg.defaultPackages;

      programs.zsh.enable = mkForce cfg.zsh;
      users.defaultUserShell = mkIf cfg.zsh pkgs.zsh;

      hardware.i2c.enable = true;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };

      fonts = {
        enableDefaultPackages = mkForce true;
        packages = cfg.fonts;
      };

      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      
      system.copySystemConfiguration = false;
    };
  };
}

