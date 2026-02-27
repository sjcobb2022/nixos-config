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
    # ./disko.nix

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
    ../common/optional/steam-hardware.nix
    ../common/optional/nvidia.nix

    # ../specializations/gnome.nix
  ];

  # boot.initrd.postResumeCommands = lib.mkAfter ''
  #   mkdir /btrfs_tmp
  #   mount /dev/root_vg/root /btrfs_tmp
  #   if [[ -e /btrfs_tmp/root ]]; then
  #       mkdir -p /btrfs_tmp/old_roots
  #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
  #   fi
  #
  #   delete_subvolume_recursively() {
  #       IFS=$'\n'
  #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
  #           delete_subvolume_recursively "/btrfs_tmp/$i"
  #       done
  #       btrfs subvolume delete "$1"
  #   }
  #
  #   for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
  #       delete_subvolume_recursively "$i"
  #   done
  #
  #   btrfs subvolume create /btrfs_tmp/root
  #   umount /btrfs_tmp
  # '';

  services.logind.settings.Login.HandleLidSwitch = "suspend";

  networking.hostName = "slaptop";

  boot = {
    kernelPatches = [
      {
        name = "fixup-hp-omen-led-patch";
        patch = ./hp-mute-led.patch;
      }
    ];
    # we love grub!
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    plymouth.enable = false;
    # binfmt.emulatedSystems = ["aarch64-linux"];
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
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
