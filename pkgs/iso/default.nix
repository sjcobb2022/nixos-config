{ pkgs, inputs, ... }:
inputs.nixos-generators.nixosGenerate {

  inherit (pkgs) system;

  modules = [
    # you can include your own nixos configuration here, i.e.

    # ../../hosts/common/global/default.nix
    # ../../hosts/common/users/sjcobb

    # ../../hosts/common/optional/blueman.nix
    # ../../hosts/common/optional/thunar.nix
    # ../../hosts/common/optional/tlp.nix
    # ../../hosts/common/optional/swaylock.nix
    # ../../hosts/common/optional/upower.nix

  ];

  format = "install-iso";
}
