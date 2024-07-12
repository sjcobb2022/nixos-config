{pkgs, modulesPath, ...}: {
  imports = [
    "${toString modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  formatAttr = "isoImage";
  fileExtension = ".iso";
}
