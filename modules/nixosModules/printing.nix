{
  flake.nixosModules.customOptions = { pkgs, config, lib, ... }: with lib;
  let
    cfg = config.misper.connection.printing;
  in {
    options.misper.connection.printing = {
      enable = mkEnableOption "Printing";
      autodiscovery = mkEnableOption "Autodiscovery";
      drivers = mkOption {
        type = types.listOf types.package;
        default = [];
      };
    };
    config = mkIf cfg.enable {
      services.printing = {
        enable = true;
        drivers = cfg.drivers;
      };

      services.avahi = mkIf cfg.autodiscovery {
        enable = true;
        openFirewall = true;
      };
    };
  };
}