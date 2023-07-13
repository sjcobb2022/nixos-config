{
  services.tlp = {
    enable = lib.mkDefault ((lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
                                       || !config.services.power-profiles-daemon.enable);
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
    };
  };
}
