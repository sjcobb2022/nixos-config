{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovide
  ];
  
  # home.sessionVariables.EDITOR = "neovide";

  # programs.neovide = {
  #   enable = true;
  # };
}
