# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/52faf9be-27d7-4c25-bc80-4d6a4508bc4f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-04fe8373-ea32-482e-a927-8c71147de109".device = "/dev/disk/by-uuid/04fe8373-ea32-482e-a927-8c71147de109";

  fileSystems."/var/lib/nixos" =
    { device = "/persist/var/lib/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" =
    { device = "/persist/var/log";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/etc/NetworkManager" =
    { device = "/persist/etc/NetworkManager";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/srv" =
    { device = "/persist/srv";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/systemd" =
    { device = "/persist/var/lib/systemd";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5C92-938C";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
