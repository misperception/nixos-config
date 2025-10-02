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
      draganddrop = true;
    };
  };
  users.users.misper.extraGroups = [ "vboxsf" ];
}
