{pkgs, ...}: {
  qt = {
    enable = true;
    # platformTheme.name = "gtk";
    # style = {
    #   name = "gtk3";
    #   package = pkgs.qt6Packages.qt6gtk2;
    # };
  };
}
