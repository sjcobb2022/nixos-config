{ pkgs, inputs, config, lib, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-15-en1007sa

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
  ];

  security.pki.certificateFiles = [
    ./CA-3EA5E6E5BB060084AA0C733C499C11F4828FC1FB.cer
    ./CA-7512C298D4BAF4863B833F3CDEE56EEAE93EDCCA.cer
  ];

  networking = {
    networkmanager.enable = true;
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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # nvidia bullshit
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

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

  specialisation.gnome = {
    inheritParentConfig = true;
    configuration = {
      services.greetd.enable = lib.mkForce false;
      services.pipewire.enable = lib.mkForce false;
      services.xserver.enable = lib.mkForce true;
      services.xserver.displayManager.gdm.enable = lib.mkForce true;
      services.xserver.desktopManager.gnome.enable = lib.mkForce true;

      environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
      services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

      environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
      ]) ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);
    };
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 5173 4173 80 443 1522 27017 ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  system.stateVersion = "23.05";
} 
