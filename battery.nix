{ ... }:{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      DEVICES_TO_ENABLE_ON_AC="bluetooth wifi wwan";
      DEVICES_TO_ENABLE_ON_BAT="bluetooth wifi wwan";
      DEVICES_TO_DISABLE_ON_BAT="";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="";
      DEVICES_TO_ENABLE_ON_STARTUP="bluetooth wifi wwan";
      RUNTIME_PM_ON_AC="on";
      RUNTIME_PM_ON_BAT="on";
    };
  };
}
