
{ pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-en00015p

    ./hardware-configuration.nix

    ../common/global
    ../common/users/sjcobb

    ../common/optional/greetd.nix
    ../common/optional/grub.nix
    ../common/optional/pipewire.nix
  ];

  # TODO: theme "greeter" user GTK instead of using misterio to login
  services.greetd.settings.default_session.user = "sjcobb";

  networking = {
    hostName = "slaptop";
    networkmanager.enable = true;
  };

  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    plymouth.enable = false;
  };

  programs = {
    # adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  system.stateVersion = "22.11";
} 
