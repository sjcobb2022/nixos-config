{ pkgs, lib, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{

  home.packages = with pkgs; [ xfce.thunar ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # home = {
  #   sessionVariables.BROWSER = "firefox";
  #   persistence = {
  #     "/persist/home/sjcobb".directories = [ ".mozilla/firefox" ];
  #   };
  # };
  #
  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = [ "firefox.desktop" ];
  #   "text/xml" = [ "firefox.desktop" ];
  #   "x-scheme-handler/http" = [ "firefox.desktop" ];
  #   "x-scheme-handler/https" = [ "firefox.desktop" ];
  # };
}
