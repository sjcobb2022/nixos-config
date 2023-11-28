{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = false;
      timeout = lib.mkDefault 15;
      grub = {
        configurationLimit = 25;
        enable = lib.mkDefault true;
        efiSupport = true;
        default = "saved";
        # efiInstallAsRemovable = true; # grub will use efibootmgr
        device = "nodev"; # "/dev/sdx", or "nodev" for efi only
        useOSProber = true;
        enableCryptodisk = true;
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
