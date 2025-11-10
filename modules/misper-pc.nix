let 
  bootModules = ( map (path: ./boot + path) [
    /tuigreet.nix
    /plymouth/plymouth-blahaj.nix
  ]);
  catppuccin = [ ./catppuccin ];
  connectionModules = (map (path: ./connection + path)[
    /printing
  ]);
  displayManagers = [ ./displayman ] ++ (map (path: ./displayman + path)[
    /gnome
    /sway
  ]);
  drives = [ ./drives/misper-pc ];
  gamingModules = (map (path: ./gaming + path)[
    /steam.nix
  ]);
  graphicsModules = (map (path: ./graphics + path) [
    /nvidia.nix
  ]);
  keyboardModules = (map (path: ./keyboard + path)[
    /qmk.nix
    /layout.nix
  ]);
  virtualisationModules = (map (path: ./virtualisation + path)[
    /virt-manager.nix
    /docker.nix
  ]);
  hardwareConfiguration = [ ./hardware/config/misper-pc/hardware-configuration.nix ];
in {
  imports = 
    bootModules ++
    catppuccin ++
    connectionModules ++
    displayManagers ++
    drives ++
    gamingModules ++
    graphicsModules ++
    hardwareConfiguration ++
    keyboardModules ++
    virtualisationModules;

    networking.firewall = {
      allowedTCPPorts = [
        161
        162
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
}
