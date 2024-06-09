{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprlock = lib.getExe pkgs.hyprlock;
  loginctl = lib.getExe' pkgs.systemd "loginctl";
  systemctl = lib.getExe' pkgs.systemd "systemctl";
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "${hyprctl} dispatch dpms on"; # turn on display after resume.
        before_sleep_cmd = "${loginctl} lock-session"; # lock before suspend.
        lock_cmd = "pidof ${hyprlock} || ${hyprlock}"; # lock screen.
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${loginctl} lock-session"; # lock screen.
        }

        {
          timeout = 330;
          on-timeout = "${hyprctl} dispatch dpms off"; # turn off display.
          on-resume = "${hyprctl} dispatch dpms on"; # turn on display.
        }

        {
          timeout = 600;
          on-timeout = "${systemctl} suspend"; # suspend.
        }
      ];
    };
  };
}
