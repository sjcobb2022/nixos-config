{
  pkgs,
  lib,
  config,
  ...
}: let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock --daemonize";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pgrep = "${pkgs.procps}/bin/pgrep";
  isLocked = "${pgrep} -x ${swaylock}";
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    package = pkgs.unstable.swayidle;
    events = [
      {
        event = "before-sleep";
        command = "${hyprctl} dispatcher dpms off ";
      }

      {
        event = "before-sleep";
        command = "${isLocked} && ${swaylock}";
      }

      {
        event = "before-sleep";
        command = "${playerctl} pause";
      }

      {
        event = "lock";
        command = "${isLocked} && ${swaylock}";
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
        timeout = 5 * 60 - 5;
        command = "${isLocked} && ${swaylock}";
      }

      {
        timeout = 10 * 60;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
