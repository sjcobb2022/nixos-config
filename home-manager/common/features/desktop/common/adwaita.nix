{pkgs, ...}: {
  home.packages = with pkgs; [
    adwaita-icon-theme
    gtk-engine-murrine
    gnome-themes-extra
  ];
}
