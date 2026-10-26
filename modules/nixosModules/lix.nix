{
  flake.nixosModules.customOptions = { pkgs, config, lib, ...}: with lib;
  let 
    cfg = config.misper.lix;
  in {
    options.misper.lix = {
      enable = mkEnableOption "Enable the Lix Package Manager";
    };
    config = mkIf cfg.enable {
      # Add overlay to nixpkgs to pin Lix version across tools
      nixpkgs.overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena;
        })
      ];
      nix.package = mkForce pkgs.lixPackageSets.stable.lix;
    };
  };
}