{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
    guest = {
      enable = true;
      clipboard = true;
      dragAndDrop = true;
    };
  };
  users.users.misper.extraGroups = [ "vboxsf" ];
}
