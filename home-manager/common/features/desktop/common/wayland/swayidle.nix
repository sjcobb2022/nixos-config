{ pkgs, lib, config, ... }:

let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock --daemonize";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
in
{
  services.swayidle = {
    enable = true;
    package = pkgs.unstable.swayidle;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${hyprctl} dispatcher dpms off ";
      }

      {
        event = "before-sleep";
        command = "${swaylock}";
      }

      {
        event = "lock";
        command = "${swaylock}";
      }

      {
        event = "after-resume";
        command = "${hyprctl} dispatcher dpms on";
      }

    ];
    timeouts = [
      {
        timeout = 5 * 60;
        command = "${hyprctl} dispatcher dpms off";
        resumeCommand = "${hyprctl} dispatcher dpms on";
      }

      {
        timeout = 5 * 60;
        command = "${swaylock}";
      }

      {
        timeout = 5 * 10;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

}
