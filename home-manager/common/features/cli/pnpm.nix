{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages_latest.pnpm
  ];
}
