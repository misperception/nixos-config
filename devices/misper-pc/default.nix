{ pkgs, ... }:
let
  makeDrive = root: {
    device = "/dev/disk/by-uuid/${root}";
    fsType = "ext4";
  };
in {
  imports = [
    ./hardware-configuration.nix
  ];

  fileSystems = {
      # 1TB HDD @ /run/media/misper/data
      "/run/media/misper/data" = (makeDrive "a6ecceb0-3a59-4057-bef3-863453470607");
      # 128 SDD @ /run/media/misper/games
      "/run/media/misper/games" = (makeDrive "076e290f-f281-4f77-a44a-a1f9b259d1b4");
  };

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
      hostname = "misper-pc";
      zsh = true;
    };
    boot = {
      ly.enable = true;
      plymouth = {
        enable = true;
        blahaj.enable = true;
      };
    };
    connection = {
      bluetooth.package = pkgs.blueberry;
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
      sway = {
        enable = true;
        package = pkgs.swayfx;
        nvidiaSupport = true;
      };
    };
    gaming.steam.enable = true;
    hardware.graphics.nvidia = {
      enable = true;
      enable32Bit = true;
    };
    keyboard = {
      layoutVariant = "altgr-intl";
      ime = true;
      qmk = {
        enable = true;
        via = true;
      };
    };
    virtualization = {
      docker = {
        enable = true;
        rootless = true;
      };
      virt-manager.enable = true;
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  networking.firewall = {
    allowedTCPPorts = [
      161
      162
      8006
      8023
      9100
      11476
    ];
    allowedUDPPorts = [
      161
      162
      9100
    ];
  };
  
  users.users.misper = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
  };
}