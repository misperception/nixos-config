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
  keyboardModules = (map (path: ./keyboard + path)[
    /layout.nix
  ]);
  virtualisationModules = (map (path: ./virtualisation + path)[
    /virtualbox.nix
  ]);
in {
  imports = 
    bootModules ++
    catppuccin ++
    connectionModules ++
    displayManagers ++
    graphicsModules ++
    keyboardModules ++
    virtualisationModules;

    networking.firewall = {
      allowedTCPPorts = [];
      allowedUDPPortRanges = [];
    };
}