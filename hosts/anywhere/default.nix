{ inputs, config, lib, pkgs, meta, ... }: {
  # imports = [
  #  inputs.disko.nixosModules.disko
  #   ./hardware-configuration.nix
  #   ./disko.nix
  # ];
  #
  # nix = {
  #   package = pkgs.nixFlakes;
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };
  #
  # # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  #
  # networking.hostName = meta.hostName; # Define your hostname.
  # # Pick only one of the below networking options.
  # # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  #
  #
  # nix.gc.dates = "daily";
  #
  # time.timeZone = "Europe/London";
  #
  # i18n.defaultLocale = "en_GB.UTF-8";
  #
  # users.users.sjcobb = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  #   # Created using mkpasswd
  #   hashedPassword = "$6$boeeGfBQwmruYktg$VYRWoEDq.UW95uLBGpsx.74NvZGSQmc4D/hmFDcv2hRE1eqgEjyZEmzFDoEggLdOOZEFk0bv2ZMZBsPxkrdyQ0";
  #   openssh.authorizedKeys.keys = [
  #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVLvW6d2dNzwdUycm+08wGFXyECPyd3QfytGjr/hO2e sjcobb"
  #   ];
  # };
  #
  # # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  #
  # # Open ports in the firewall.
  # # networking.firewall.allowedTCPPorts = [ 80 ];
  # # networking.firewall.allowedUDPPorts = [ ... ];
  # # Or disable the firewall altogether.
  # networking.firewall.allowedTcpPorts = [ 22 80 443 ];
  #
  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  #
  # system.stateVersion = "24.05";
}
