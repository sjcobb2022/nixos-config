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
    ../common/features/games
  ];

  home = {
    username = lib.mkDefault "guest";
  };

  colorscheme = inputs.nix-colors.colorSchemes.tokyo-city-terminal-dark;
  home.file.".colorscheme".text = config.colorscheme.slug;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
