{pkgs, ...}: {
  home.packages = with pkgs; [qt6.qtwayland libsForQt5.qt5.qtwayland];
  qt = {
    enable = true;
    platformTheme = "gtk";
    # style = {
    #   name = "gtk3";
    #   package = pkgs.qt6Packages.qt6gtk2;
    # };
  };
}
