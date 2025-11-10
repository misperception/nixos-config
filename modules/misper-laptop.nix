let 
  bootModules = ( map (path: ./boot + path) [
    /gdm.nix
    /plymouth/plymouth-catppuccin.nix
  ]);
  catppuccin = [ ./catppuccin ];
  connectionModules = (map (path: ./connection + path)[
    /printing
  ]);
  displayManagers = [ ./displayman ] ++ (map (path: ./displayman + path)[
    /gnome
    /sway
  ]);
  graphicsModules = (map (path: ./graphics + path) [
    /intel.nix
  ]);
  hardwareModules = (map (path: ./hardware + path) [
    /battery.nix
  ]);
  keyboardModules = (map (path: ./keyboard + path)[
    /layout.nix
  ]);
  virtualisationModules = (map (path: ./virtualisation + path)[
    /virtualbox.nix
    /virt-manager.nix
    /docker.nix
  ]);
  hardwareConfiguration = [ ./hardware/config/misper-laptop/hardware-configuration.nix ];
in {
  imports = 
    bootModules ++
    catppuccin ++
    connectionModules ++
    displayManagers ++
    graphicsModules ++
    hardwareModules ++
    hardwareConfiguration ++
    keyboardModules ++
    virtualisationModules;

    networking.firewall = {
      allowedTCPPorts = [];
      allowedUDPPortRanges = [];
    };
}
