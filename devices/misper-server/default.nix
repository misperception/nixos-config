{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
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
  services.github-nix-ci = {
    age.secretsDir = ./secrets;
    personalRunners = {
      "misperception/estanteria-bot".num = 1;
    };
  };
  boot.kernelParams = [ "quiet" "splash" "consoleblank=10" ];         
  environment.systemPackages = with pkgs; [ neovim ];
  services.logind = {                                        
    lidSwitch = "ignore";                                    
    lidSwitchExternalPower = "ignore";                       
  };
}
