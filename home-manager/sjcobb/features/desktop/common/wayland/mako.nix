{ config, ... }:
let inherit (config.colorscheme) colors kind;
in {
  programs.mako = {
    enable = true;
    iconPath =
      if kind == "dark" then
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
      else
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10,20";
    anchor = "top-center";
    width = 315;
    height = 200;
    borderSize = 5;
    defaultTimeout = 5000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
  };
}
