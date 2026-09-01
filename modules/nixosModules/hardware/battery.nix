{ config, lib, ... }: with lib; let
  cfg = config.misper.hardware.battery;
in {
  options.misper.hardware.battery = {
    enable = mkEnableOption "Battery management";
    cpuPercentageOnBattery = mkOption {
      type = types.int;
      default = 66;
    };
  };
  config = mkIf cfg.enable {
    services.power-profiles-daemon.enable = mkForce false;
    # Enable Power Management
    powerManagement.enable = mkForce true;
    # Enable Thermald (thermal handling)
    services.thermald.enable = mkForce true;

    # Enable TLP
    services.tlp = {
      enable = mkForce true;
      settings = {
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = mkForce cfg.cpuPercentageOnBattery;
        CPU_ENERGY_PERF_POLICY_ON_BAT = mkForce "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = mkForce "performance";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
