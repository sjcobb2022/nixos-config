{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 18;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = 18;
  };
}
