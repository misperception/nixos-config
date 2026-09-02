{
  flake.nixosModules.customOptions = { config, lib, ... }: with lib;
  let
    cfg = config.misper.upgrades;
  in {
    options.misper.upgrades = {
      enable = mkEnableOption "Enable automatic upgrades";
      path = mkOption {
        type = types.str;
	default = "github:misperception/nixos-config";
      };
      date = mkOption {
        type = types.str;
	default = "Sunday 00:00";
      };
    };
    config = mkIf cfg.enable {
      system.autoUpgrade = {
        enable = true;
	dates = mkForce cfg.date;
	flake = mkForce cfg.path;
      };
    };
  };
}
