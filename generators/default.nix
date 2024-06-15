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

  hyprland-iso = inputs.nixos-generators.nixosGenerate {
    system = "${pkgs.system}";
    format = "iso";
    customFormats = {iso = import ./formats/hyprland-iso.nix;};
    modules = [
      ../hosts/iso
      ../home-manager/guest/iso.nix
      ../home-manager/common/global
      ../home-manager/common/features/desktop/hyprland
      ../home-manager/common/features/desktop/common/qt.nix
      ../home-manager/common/features/desktop/common/gtk.nix
      ../home-manager/common/features/desktop/common/pavucontrol.nix
      ../home-manager/common/features/desktop/common/wayland
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
