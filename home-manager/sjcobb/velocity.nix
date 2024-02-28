{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModule
    ../common/global
  ];

  home = {
    username = lib.mkDefault "sjcobb";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
