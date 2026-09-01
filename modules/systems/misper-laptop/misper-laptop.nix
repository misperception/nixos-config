{ inputs, self,  ... }: {
  flake.nixosConfigurations.misper-laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.customOptions
      self.nixosModules.misper-laptop
      inputs.catppuccin.nixosModules.catppuccin
    ];
  };

  flake.nixosModules.misper-laptop = { pkgs, ... }: {
    imports = [
      ./_hw/hardware-configuration.nix
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
            blur-my-shell
            dash2dock-lite
            lockscreen-extension
            removable-drive-menu
            system-monitor # Resource usage
            user-themes
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
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
    };

    users.users.misper = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" ];
    };

    services.fwupd.enable = true;
  };
}