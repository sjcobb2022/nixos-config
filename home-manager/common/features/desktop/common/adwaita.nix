{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome3.adwaita-icon-theme
    gtk-engine-murrine
    gnome.gnome-themes-extra
  ];
}
