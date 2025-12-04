{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  specialisation.gnome = {
    inheritParentConfig = false;
    configuration = {
      environment.etc."specialisation".text = "gnome";

      imports = [
        inputs.nixos-hardware.nixosModules.omen-15-en1007sa
        ../common/optional/nvidia.nix
        ../common/optional/steam-hardware.nix

        ../common/global
        ../common/users/guest

        ../slaptop/hardware-configuration.nix
      ];

      qt = {
        enable = lib.mkForce true;
      };

      networking.hostName = "slaptop";

      programs.steam.enable = true;

      services.gnome.gcr-ssh-agent.enable = false;

      networking = {
        networkmanager = {
          enable = lib.mkDefault true;
          insertNameservers = ["1.1.1.1" "1.0.0.1"];
        };
      };

      users.users.guest.extraGroups = ["wheel"];

      swapDevices = [
        {
          device = "/swapfile";
          size = 16 * 1024;
        }
      ];

      hardware = {
        xone.enable = true;
      };

      services.joycond.enable = true;

      services.pulseaudio.enable = false;
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      environment.systemPackages = with pkgs; [gnomeExtensions.appindicator adwaita-icon-theme];
      services.udev.packages = with pkgs; [gnome-settings-daemon];

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = lib.mkForce false;
        powerManagement.finegrained = lib.mkForce false;
        open = lib.mkForce false;
      };

      environment.gnome.excludePackages = with pkgs; [
        orca
        evince
        geary
        gnome-backgrounds
        gnome-tour # GNOME Shell detects the .desktop file on first log-in.
        gnome-user-docs
        baobab
        epiphany
        gnome-text-editor
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-console
        gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        gnome-music
        gnome-weather
        gnome-connections
        simple-scan
        snapshot
        totem
        yelp
        gnome-software
      ];

      system.stateVersion = "23.05";
    };
  };
}
