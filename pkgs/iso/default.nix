{ inputs, ... }:

inputs.nixos-generators.nixosGenerate {

  system = pkgs.system;

  modules = [
    # you can include your own nixos configuration here, i.e.
    # ../../hosts/common/global
  ];

  format = "install-iso";
}
