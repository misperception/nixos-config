{ pkgs, ... }:
{
    # Enable Virt-manager
    programs.virt-manager.enable = true;
    # Add users to the libvirtd group
    users.groups.libvirtd.members = [ "misper" ];
    # Enable libvirtd daemon
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
    # Enable USB redirection
    virtualisation.spiceUSBRedirection.enable = true;

    # Enable IOMMU (for GPU passthrough)
    boot.kernelParams = [ "intel_iommu=on" ];
}
