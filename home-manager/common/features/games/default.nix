{pkgs, ...}: {
  imports = [
    ./steam.nix
    ./prism-launcher.nix
    ./r2modman.nix
  ];
}
