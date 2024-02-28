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
    ../common/features/nvim
    ../common/features/desktop/hyprland
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
  ];

  home = {
    username = lib.mkDefault "sjcobb";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
