{pkgs, ...}: {
  qt = {
    enable = true;
    # platformTheme.name = "adwaita";
    # style = {
    #   name =  "adwaita-dark";
    # };
    # style = "adwaita-dark";
    platformTheme = {
      name = "gtk";
    };
    style = {
      name = "gtk3";
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
}
