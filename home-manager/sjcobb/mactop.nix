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
  programs.alacritty.settings.shell = lib.mkForce "${pkgs.fish}/bin/fish";
  programs.alacritty.settings.terminal = lib.mkForce {};

  home = {
    username = lib.mkDefault "sjcobb";
    homeDirectory = lib.mkForce "/Users/sjcobb";
  };

  programs.gh.enable = true;

  home.sessionVariables.LIBRARY_PATH = ''${lib.makeLibraryPath [pkgs.libiconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-sdk-7.0.410"
      ];
    };
  };

  home.packages = with pkgs; [
    spotify
    (with dotnetCorePackages;
      combinePackages [
        dotnet-sdk_8
        dotnet-sdk_7
      ])
    nodejs
    (unstable.yarn.override {nodejs = nodePackages_latest.nodejs;})
    stripe-cli
  ];
}
