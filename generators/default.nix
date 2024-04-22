{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  plasma-iso = inputs.nixos-generators.nixosGenerate {
    system = "${pkgs.system}";
    format = "iso";
    customFormats = {iso = import ./formats/plasma-iso.nix;};
    modules = [
      ../hosts/iso
    ];
  };

  gnome-iso = inputs.nixos-generators.nixosGenerate {
    system = "${pkgs.system}";
    format = "iso";
    customFormats = {iso = import ./formats/gnome-iso.nix;};
    modules = [
      ../hosts/iso
    ];
  };

  minimal-iso = inputs.nixos-generators.nixosGenerate {
    system = "${pkgs.system}";
    format = "iso";
    modules = [
      ../hosts/iso
    ];
  };
}
