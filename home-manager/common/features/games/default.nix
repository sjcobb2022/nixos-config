{ pkgs, ... }: {
  imports = [
    ./lutris.nix
    ./steam.nix
    ./prism-launcher.nix
    ./r2modman.nix
  ];
}
