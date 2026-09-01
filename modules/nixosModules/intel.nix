{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib;
  let
    parent = config.misper.hardware.graphics;
    cfg = parent.intel;
  in {
    options.misper.hardware.graphics.intel = {
      enable = mkEnableOption "Intel OCL";
    };
    config = mkIf cfg.enable {
      hardware.graphics.extraPackages = with pkgs; [ intel-ocl ];
    };
  };
}
