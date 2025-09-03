{config, ...}: let
  inherit (config.colorscheme) palette variant;
in {
  services.mako = {
    enable = true;
    settings = {
      icon-path =
        if variant == "dark"
        then "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
        else "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
      font = "${config.fontProfiles.regular.family} 12";
      padding = "10";
      margin = "5";
      layer = "overlay";
      width = 315;
      max-icon-size = 70;
      height = 200;
      border-size = 2;
      border-radius = 0;
      default-timeout = 5000;
      background-color = "#${palette.base00}dd";
      border-color = "#${palette.base03}dd";
      text-color = "#${palette.base05}dd";
      "urgency=high" = {
        ignore-timeout = 1;
        border-color = "#${palette.base08}dd";
      };
    };
  };
}
