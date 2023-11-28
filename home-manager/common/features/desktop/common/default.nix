{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./mpd.nix
    ./wpa-gui.nix
    ./adwaita.nix
  ];

  xdg.mimeApps.enable = true;
  # xdg.portal.enable = true;
  # home.packages = with pkgs; [
  #   xdg-utils-spawn-terminal
  # ];
}
