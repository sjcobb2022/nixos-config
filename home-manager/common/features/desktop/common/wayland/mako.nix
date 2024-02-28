{config, ...}: let
  inherit (config.colorscheme) palette variant;
in {
  services.mako = {
    enable = true;
    iconPath =
      if variant == "dark"
      then "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
      else "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
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
    backgroundColor = "#${palette.base00}dd";
    borderColor = "#${palette.base03}dd";
    textColor = "#${palette.base05}dd";
    extraConfig = ''
      [urgency=high]
      ignore-timeout=1
      border-color=#${palette.base08}dd
    '';
  };
}
