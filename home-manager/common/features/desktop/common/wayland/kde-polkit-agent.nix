{ config, pkgs, lib, ... }:

let inherit (config.colorscheme) colors;
in
{
  home.packages = with pkgs; [ polkit-kde-agent ];
}
