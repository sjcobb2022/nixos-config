{
  boot = {
    loader = {
      systemd-boot.enable = false;
      # TODO: move this
      # efi = {
      #  canTouchEfiVariables = true;
      #  efiSysMountPoint = "/boot/efi";
      # };
      grub = {
        configurationLimit = 5;
        enable = true;
        efiSupport = true;
        # efiInstallAsRemovable = true;  # grub will use efibootmgr
        device = "nodev";  # "/dev/sdx", or "nodev" for efi only
        useOSProber = true;
      };
    };
    # TODO: move this
    # plymouth.enable = false;
  };
}
