{
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        configurationLimit = 10;
        enable = true;
        efiSupport = true;
	default = "saved";
        # efiInstallAsRemovable = true;  # grub will use efibootmgr
        device = "nodev";  # "/dev/sdx", or "nodev" for efi only
        useOSProber = true;
	timeout = 15;
	extraEntriesBeforeNixOS = true;
	extraEntries = ''
	  menuentry 'UEFI Firmware Settings' {
	    fwsetup
	  }

	  menuentry 'Reboot' {
	    reboot
	  }

	  menuentry 'Shutdown' {
	    halt
	  } 
	'';
      };
    };
  };
}
