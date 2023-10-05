{ lib, config, ... }:
{
  services.tlp = {
    enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
      || !config.services.power-profiles-daemon.enable);
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };
}
