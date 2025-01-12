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
  ];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  # use US keyboard because laptop is in US keyboard layout
  services.xserver = {
    layout = "us";
    xkb.variant = "";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["amd" "nvidia"];

  networking = {
    hostName = "nixos-iso";
    wireless.enable = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [libvdpau-va-gl vaapiVdpau];
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
    allowedTCPPorts = [80 8080];
  };

  system.stateVersion = "23.05";
}
