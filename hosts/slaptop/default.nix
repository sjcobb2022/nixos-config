{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-15-en1007sa
    # outputs.nixosModules.slaptop
    ./hardware-configuration.nix

    ../common/global
    ../common/users/sjcobb
    ../common/users/guest

    ../common/optional/greetd.nix
    ../common/optional/grub.nix
    ../common/optional/pipewire.nix
    ../common/optional/bluetooth.nix
    ../common/optional/blueman.nix
    ../common/optional/thunar.nix
    ../common/optional/tlp.nix
    ../common/optional/wireless.nix

    ../common/optional/hyprlock.nix
    ../common/optional/docker.nix
    ../common/optional/upower.nix
    ../common/optional/virt-manager.nix
    ../common/optional/steam-hardware.nix
    ../common/optional/android.nix
    ../common/optional/nvidia.nix

    ../specializations/gnome.nix
  ];

  services.logind = {
    lidSwitch = "suspend";
  };

  networking.hostName = "slaptop";

  boot = {
    # we love grub!
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    plymouth.enable = false;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [3000 5173 4173 1522 27017];
    checkReversePath = false;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  services.udev.packages = [pkgs.swayosd];

  system.stateVersion = "23.05";
}
