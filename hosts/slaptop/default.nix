
{ pkgs, inputs, config, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-en00015p

    ./hardware-configuration.nix

    ../common/global
    ../common/users/sjcobb

    ../common/optional/greetd.nix
    ../common/optional/grub.nix
    ../common/optional/pipewire.nix
    # ../common/optional/wireless.nix
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

  # nvidia bullshit
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  # steam bullshit
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  services.logind = {
    lidSwitch = "suspend";
  };


  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  boot = {
    # we love grub!
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
    dconf.enable = true;
    kdeconnect.enable = true;
  };
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  system.stateVersion = "23.05";
} 
