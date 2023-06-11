{ config, pkgs, ... }:
{
  # home.sessionVariables.EDITOR = "nvim";
  imports = [
    ./neovide.nix
  ];
  programs.neovim = {
    enable = true;
  };
}
