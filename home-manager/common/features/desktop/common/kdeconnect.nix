{ pkgs, lib, ... }:
let
  kdeconnect-cli = "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnect-cli";
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
      name = "KDE Connect";
      settings.NoDisplay = "true";
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  home.persistence = {
    "/persist/home/sjcobb".directories = [ ".config/kdeconnect" ];
  };
}
