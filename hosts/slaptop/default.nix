
{ pkgs, inputs, config, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-en00015p

    ./hardware-configuration.nix

    ../common/global
    ../common/users/sjcobb

    # ../common/optional/greetd.nix
    ../common/optional/grub.nix
    ../common/optional/pipewire.nix
  ];

  # TODO: theme "greeter" user GTK instead of using misterio to login
  # services.greetd.settings.default_session.user = "sjcobb";

  networking = {
    hostName = "slaptop";
    networkmanager.enable = true;
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

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  boot = {
    # we love grub!
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    plymouth.enable = false;
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  system.stateVersion = "23.05";
} 
