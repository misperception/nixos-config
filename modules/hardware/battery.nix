{
  services.power-profiles-daemon.enable = false;
  # Enable Power Management
  powerManagement.enable = true;
  # Enable Thermald (thermal handling)
  services.thermald.enable = true;

  # Enable TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 50;
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;


      # Battery thresholds
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
