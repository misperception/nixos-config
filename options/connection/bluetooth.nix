{ pkgs, config, lib, ... }: with lib; let
  cfg = config.misper.connection.bluetooth;
in {
  options.misper.connection.bluetooth = {
    enable = mkEnableOption "Bluetooth";
    package = mkOption {
      type = types.package;
      default = pkgs.blueman;
    };
  };
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = mkForce true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
    environment.systemPackages = [ cfg.package ];
  };
}
