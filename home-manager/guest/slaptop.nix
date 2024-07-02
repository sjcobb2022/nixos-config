# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.nix-colors.homeManagerModule
    ../common/global
    ../common/features/desktop/common
    ../common/features/desktop/hyprland
    ../common/features/games
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = lib.mkDefault "guest";
  };

  wayland.windowManager.hyprland.settings.env = [
    "WLR_DRM_DEVICES,/home/${config.home.username}/.config/hypr/card"
    "XDG_SESSION_TYPE,wayland"
    "MOZ_ENABLE_WAYLAND,1"
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
