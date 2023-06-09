{
  boot = {
    loader = {
      systemd-boot.enable = false;
      timeout = 15;
      grub = {
        configurationLimit = 10;
        enable = true;
        efiSupport = true;
	default = "saved";
        # efiInstallAsRemovable = true;  # grub will use efibootmgr
        device = "nodev";  # "/dev/sdx", or "nodev" for efi only
        useOSProber = true;
	extraEntriesBeforeNixOS = true;
	extraEntries = ''

	  menuentry 'Shutdown' {
	    halt
	  } 
	  
	  menuentry 'Reboot' {
	    reboot
	  }
	  
	  menuentry 'UEFI Firmware Settings' {
	    fwsetup
	  }
	'';
      };
    };
  };
}
