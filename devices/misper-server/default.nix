{ pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ./arion.nix
    ./services.nix
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
    extraGroups = [ "wheel" "input" ];
  };
  boot.kernelParams = [ "quiet" "splash" "consoleblank=10" ];         
  environment.systemPackages = with pkgs; [ neovim gh lazydocker zoxide ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  environment.shellAliases = {
    switch = "sudo nixos-rebuild switch --flake /etc/nixos#misper-server";
  };
  services.logind.settings.Login = {                                        
    HandleLidSwitch = "ignore";                                    
    HandleLidSwitchExternalPower = "ignore";                       
  };
}
