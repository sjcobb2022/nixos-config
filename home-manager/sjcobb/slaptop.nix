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
    ../common/global/impermanence.nix
    ../common/features/cli/gh.nix
    ../common/features/cli/ssh.nix
    ../common/features/nvim
    ../common/features/helix
    ../common/features/desktop/hyprland
  ];

  home = {
    username = lib.mkDefault "sjcobb";
  };

  # Laptop specific configuration

  home.file = {
    ".config/hypr/card".source = config.lib.file.mkOutOfStoreSymlink "/dev/dri/by-path/pci-0000:06:00.0-card";
  };

  wayland.windowManager.hyprland.settings.env = [
    "WLR_DRM_DEVICES,/home/${config.home.username}/.config/hypr/card"
    "AQ_DRM_DEVICES,/home/${config.home.username}/.config/hypr/card"
    # "AQ_DRM_DEVICES,/dev/dri/card1"
    # "AQ_TRACE,1"
    "HYPLAND_TRACE,1"
    "XDG_SESSION_TYPE,wayland"
    "MOZ_ENABLE_WAYLAND,1"
  ];

  programs.vscode.enable = true;
  programs.vscode.package = (pkgs.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
      sha256 = "0x353gh6cjran5fww61b2ll1c7j4p05393nkzz8ms97pssn1qk91";
    };
    version = "latest";

    buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
  });

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
