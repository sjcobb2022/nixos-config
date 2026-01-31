{
  pkgs,
  lib,
  config,
  inputs,
  stdenv,
  ...
}: let
  addons = inputs.firefox-addons.packages.${stdenv.hostPlatform.system};
in {
  programs.firefox = {
    enable = true;
  };

  home = {
    sessionVariables = {
      BROWSER = "firefox";
      TZ = "/etc/localtime";
    };
    persistence = {
      "/persist".directories = [".mozilla/firefox"];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
