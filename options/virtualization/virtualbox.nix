{ config, lib, ... }: with lib; let 
  cfg = config.misper.virtualization.virtualbox;
in {
  options.misper.virtualization.virtualbox = {
    enable = mkEnableOption "Virtualbox";
    kvm = mkEnableOption "KVM support";
    guestAdditions = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = mkIf cfg.enable {
    virtualisation.virtualbox = {
      host = {
        enable = mkForce true;
        enableExtensionPack = mkForce cfg.guestAdditions;
        enableKvm = mkForce cfg.kvm;
        addNetworkInterface = false;
      };
      guest = {
        enable = mkForce true;
        clipboard = mkForce cfg.guestAdditions;
        dragAndDrop = mkForce cfg.guestAdditions;
      };
    };
    users.users.misper.extraGroups = [ "vboxsf" ];
  };
}
