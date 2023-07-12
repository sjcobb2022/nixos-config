{ config, pkgs, lib, ... }:
let inherit (config.colorscheme) colors;
in
{
  home.packages = with pkgs; [ discord discocss ];

  home.persistence = {
    "/persist/home/sjcobb".directories = [ ".config/discord" ];
  };
}
