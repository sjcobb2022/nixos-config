{pkgs, ...}: {
  imports = [
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    # ./kdeconnect.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./mpd.nix
    ./wpa-gui.nix
    ./adwaita.nix
    ./cursor.nix
    # ./stylix.nix
  ];

  home.packages = with pkgs.unstable; [keypunch];

  xdg.mimeApps.enable = true;
  xdg.configFile."mimeapps.list".force = true;
}
