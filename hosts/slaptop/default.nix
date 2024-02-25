{ pkgs, inputs, outputs, config, lib, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-15-en1007sa
    # outputs.nixosModules.slaptop
    ./hardware-configuration.nix

    ../common/global
    ../common/users/sjcobb
    ../common/users/guest

    ../common/optional/gnome.nix

    ../common/optional/greetd.nix
    ../common/optional/grub.nix
    ../common/optional/pipewire.nix
    ../common/optional/bluetooth.nix
    ../common/optional/blueman.nix
    ../common/optional/thunar.nix
    ../common/optional/tlp.nix
    ../common/optional/wireless.nix
    ../common/optional/swaylock.nix
    ../common/optional/docker.nix
    ../common/optional/upower.nix
  ];

  networking = {
    networkmanager = {
      enable = lib.mkDefault true;
    };
    hostName = "slaptop";
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  # use US keyboard because laptop is in US keyboard layout 
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  boot.kernelPackages = pkgs.linuxPackages_6_5;

  programs.hyprland.enable = true;

  # nvidia bullshit

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  hardware.nvidia = {

    # Modesetting is required.
    # Use integrated options with nvidia-offload for battery saving
    modesetting.enable = false;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = true;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Enable dynamic power management. 
    # Dynamic Boost balances power between the CPU and the GPU for improved
    # performance on supported laptops using the nvidia-powerd daemon.
    dynamicBoost.enable = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # steam bullshit
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
  };

  services.logind = {
    lidSwitch = "suspend";
  };

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
    kdeconnect.enable = true;
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 5173 4173 80 443 1522 27017 ];
  };

 swapDevices = [ 
    {
      device = "/swapfile";
      size = 16 * 1024;
    } 
  ];

  system.stateVersion = "23.05";
} 
