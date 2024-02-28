{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: {
  imports = [
    # ../common/global
    # ../common/users/sjcobb
    # ../common/users/guest

    # ../common/optional/tlp.nix
    # ../common/optional/swaylock.nix
    inputs.nixos-generators.nixosModules.all-formats
  ];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  # use US keyboard because laptop is in US keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # networking.wireless.enable = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amd" "nvidia"];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  networking = {
    hostName = "iso";
  };

  boot.kernelPackages = pkgs.linuxPackages_6_1;

  programs.hyprland.enable = true;

  # steam bullshit
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [libvdpau-va-gl vaapiVdpau];
  };

  services.logind = {
    lidSwitch = "suspend";
  };

  # boot = {
  #   # we love grub!
  #   loader = {
  #     efi = {
  #       canTouchEfiVariables = true;
  #       efiSysMountPoint = "/boot";
  #     };
  #   };
  #   plymouth.enable = false;
  # };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [3000 5173 4173 80 443 1522 27017];
  };

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };

  system.stateVersion = "23.05";
}
