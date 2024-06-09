{...}: {
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
  ];

  xdg.mimeApps.enable = true;
  xdg.configFile."mimeapps.list".force = true;
}
