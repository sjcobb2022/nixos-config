{ pkgs, ... }:
{
  home.packages = with pkgs; [ qt6.qtwayland libsForQt5.qt5.qtwayland];
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
