{ config, pkgs, lib, ... }:
let inherit (config.colorscheme) colors;
in
{
  home.packages = with pkgs; [ discord discocss ];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [ ".config/discord" ];
  };
}
