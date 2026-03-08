{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  misper = {
    base = {
      appimage = true;
      firstVersion = "24.05";
      flatpak = true;
      fonts = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        liberation_ttf
        cantarell-fonts
      ];
      garbageCollection = true;
      hostname = "misper-laptop";
      zsh = true;
    };
    boot = {
      gdm.enable = true;
      plymouth = {
        enable = true;
        catppuccin.enable = true;
      };
    };
    connection = {
      printing = {
        enable = true;
        autodiscovery = true;
        drivers = [ pkgs.hplipWithPlugin ];
      };
    };
    desktop = {
      enable = true;
      xwayland = true;
      gnome = {
        enable = true;
        extensions = with pkgs.gnomeExtensions; [ 
          appindicator # System tray icons
          system-monitor # Resource usage
          removable-drive-menu
          user-themes
          rounded-window-corners-reborn
        ];
        minimal = true;
        enableKittySupport = true;
        nautilus.preview = true;
      };
    };
    hardware = {
      battery.enable = true;
      graphics.intel.enable = true;
    };
    keyboard = {
      layoutVariant = "altgr-intl";
      ime = true;
    };
    virtualization = {
      docker = {
        enable = true;
        rootless = true;
      };
      virt-manager.enable = true;
      virtualbox = {
        enable = true;
        kvm = true;
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  users.users.misper = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
  };

  services.fwupd.enable = true;
}
