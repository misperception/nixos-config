{
  flake.nixosModules.customConfig = { pkgs, config, lib, ... }: with lib;
  let
    cfg = config.misper.virtualization.virt-manager;
  in {
    options.misper.virtualization.virt-manager = {
      enable = mkEnableOption "Virt-manager";
      usbRedirection = mkOption {
        type = types.bool;
        default = true;
      };
    };
    config = mkIf cfg.enable {
      programs.virt-manager.enable = mkForce true;
      users.groups.libvirtd.members = [ "misper" ];
      virtualisation.libvirtd = {
        enable = mkForce true;
        qemu = {
          runAsRoot = true;
          swtpm.enable = true;
          vhostUserPackages = with pkgs; [ virtiofsd ];
        };
      };
      virtualisation.spiceUSBRedirection.enable = cfg.usbRedirection;
      boot.kernelParams = [ "intel_iommu=on" ];
    };
  };
}
