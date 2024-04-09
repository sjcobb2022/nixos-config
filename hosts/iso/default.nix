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
  ];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  # use US keyboard because laptop is in US keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amd" "nvidia"];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  networking = {
    hostName = "iso";
    wireless.enable = false;
  };

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

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 8080 ];
  };

  system.stateVersion = "23.05";
}
