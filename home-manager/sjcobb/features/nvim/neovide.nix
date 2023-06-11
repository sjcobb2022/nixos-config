{ config, pkgs, ... }:
{
  home.sessionVariables.EDITOR = "neovide";

  programs.neovide = {
    enable = true;
  };
}
