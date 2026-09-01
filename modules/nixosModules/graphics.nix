{
  flake.nixosModules.customOptions = { config, lib, ... }: with lib; let
    cfg = config.misper.hardware.graphics;
  in {
    options.misper.hardware.graphics = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
    config = mkIf cfg.enable {
      hardware.graphics = {
        enable = mkForce true;
        enable32Bit = mkForce true;
      };
    };
  };
}