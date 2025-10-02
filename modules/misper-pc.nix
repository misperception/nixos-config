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
  docker = [ ./docker ];
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
  ]);
in {
  imports = 
    bootModules ++
    catppuccin ++
    connectionModules ++
    displayManagers ++
    docker ++
    drives ++
    gamingModules ++
    graphicsModules ++
    keyboardModules ++
    virtualisationModules;
}