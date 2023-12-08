{ pkgs, lib, config, ... }:
let
  # kdeconnect-cli = "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnect-cli";
in
{
  xdg.desktopEntries = {
    "org.kde.kdeconnect.sms" = {
      exec = "";
      name = "KDE Connect SMS";
      settings.NoDisplay = "true";
    };
    "org.kde.kdeconnect.nonplasma" = {
      exec = "";
      name = "KDE Connect Indicator";
      settings.NoDisplay = "true";
    };
    "org.kde.kdeconnect.app" = {
      exec = "";
      name = "kde connect";
      settings.NoDisplay = "true";
    };
    "org.kde.kdeconnect_open" = {
      exec = "";
      name = "Open on connected device via KDE Connect";
      settings.NoDisplay = "true";
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # home.packages = with pkgs; [ valent ];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [ ".config/kdeconnect" ];
  };
}
