{
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        configurationLimit = 10;
        enable = true;
        efiSupport = true;
        # efiInstallAsRemovable = true;  # grub will use efibootmgr
        device = "nodev";  # "/dev/sdx", or "nodev" for efi only
        useOSProber = true;
      };
    };
  };
}
