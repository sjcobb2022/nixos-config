{ pkgs, lib, config, ... }:

let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  # pactl = "${pkgs.pulseaudio}/bin/pactl";
in
{
  programs.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }

      # TODO: use hyprctl to turn screen off. Not sure 
      # lib.optionalAttrs
      # (config.wayland.windowManager.hyprland.enable)
      # let hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl"; in 
      # { event = "after-resume"; command = "${hyprctl} dispatch dpms on"; }
    ];
    timeouts = [
      { timeout = 4 * 60; command = "${pkgs.swaylock}/bin/swaylock"; }
    ];
  };
}
