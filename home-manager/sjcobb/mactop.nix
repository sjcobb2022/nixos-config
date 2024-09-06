# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.nix-colors.homeManagerModule
    ../common/global
    ../common/features/desktop/common/wayland/alacritty.nix
    ../common/features/nvim
  ];

  programs.alacritty.settings.font.normal.family = lib.mkForce "FiraCode Nerd Font";

  home = {
    username = lib.mkDefault "sjcobb";
    homeDirectory = lib.mkForce "/Users/sjcobb";
  };

  home.packages = with pkgs; [ spotify dotnet-sdk_7 ];
}
