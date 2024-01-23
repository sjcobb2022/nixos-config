{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidia
  ];
}
