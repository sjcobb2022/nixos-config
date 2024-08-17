{ pkgs, inputs, ...}: {
  imports = [inputs.stylix.homeManagerModules.stylix];
  stylix.enable = true;
  stylix.image = ./assets/mountain.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";
}
