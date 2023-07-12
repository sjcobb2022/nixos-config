
{ inputs, lib, config, pkgs, ... }: {
  
  imports = [
    ../common
  ];

  home.packages = with pkgs; [
   gnome.gnome-session
   gnome.gnome-screenshot
  ];

  xsession = {
    enable = true;
    windowManager.command = "gnome-session";
  };
}
