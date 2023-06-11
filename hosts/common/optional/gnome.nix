{ config, lib, ... }:
{
  # TODO: Determine setup both gnome and hyprland together?
  # NOTE: may need to disable gdm and use gnome-session to start greetd 
  config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    assertions =
      [{
        assertion = !config.wayland.windowManager.hyprland.enable;
        message = "Cannot use both GNOME and Hyprland";
      }];
  };
  services = {
    xserver = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    geoclue2.enable = true;
  };
}
