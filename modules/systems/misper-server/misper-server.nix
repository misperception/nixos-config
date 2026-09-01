{ inputs, self, ... }: {
  flake.nixosConfigurations.misper-server = inputs.nixpkgs-stable.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      inputs.agenix.nixosModules.default
      inputs.arion.nixosModules.arion
      inputs.github-nix-ci.nixosModules.default
      self.nixosModules.customOptions
      self.nixosModules.misper-server
      { environment.systemPackages = [inputs.agenix.packages.${system}.default]; }
    ];
  };

  flake.nixosModule.misper-server = { pkgs, ... }: {
    imports = [ 
      ./_hw/hardware-configuration.nix
      ./_services
    ];
    misper = {
      base = {
        firstVersion = "25.05";
        hostname = "misper-server";
        garbageCollection = true;
        zsh = true;
      };
      keyboard = {
        layoutVariant = "altgr-intl";
      };
      virtualization.docker = {
        enable = true;
        rootless = true;
      };
    };
    services.openssh.enable = true;
    users.users.misper = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "docker" ];
    };
    boot.kernelParams = [ "quiet" "splash" "consoleblank=10" ];         
    environment.systemPackages = with pkgs; [ gh lazydocker ];
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    environment.shellAliases = {
      switch = "sudo nixos-rebuild switch --flake /etc/nixos#misper-server";
    };
    services.logind.settings.Login = {                                        
      HandleLidSwitch = "ignore";                                    
      HandleLidSwitchExternalPower = "ignore";                       
    };
    networking.interfaces.enp2s0.ipv4.addresses = [
      {
        address = "192.168.1.56";
        prefixLength = 24;
      }
    ];
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [ "8.8.8.8" ];
    networking.firewall.allowedTCPPorts = [
      80
      443
      8888
    ];
  }; 
}