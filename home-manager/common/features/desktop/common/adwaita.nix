{ pkgs, ... }: {
  home.packages = [ 
    pkgs.gnome.adwaita-icon-theme
    pkgs.gtk-engine-murrine
    pkgs.gnome.gnome-themes-extra
  ];
}
