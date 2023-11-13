{ config, ... }:
let inherit (config.colorscheme) colors kind;
in
{
  services.mako = {
    enable = true;
    iconPath =
      if kind == "dark" then
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
      else
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10";
    margin = "5";
    layer = "overlay";
    width = 315;
    maxIconSize = 70;
    height = 200;
    borderSize = 2;
    borderRadius = 0;
    defaultTimeout = 5000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
    extraConfig = ''
      [urgency=high]
      ignore-timeout=1
      border-color=#${colors.base08}dd
    '';
  };
}
