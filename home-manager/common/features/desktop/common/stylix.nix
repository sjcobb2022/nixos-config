{ pkgs, inputs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];
}
