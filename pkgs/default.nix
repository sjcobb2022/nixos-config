# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{pkgs ? (import ../nixpkgs.nix) {}, ...}: {
  # example = pkgs.callPackage ./example { };
  shellcolord = pkgs.callPackage ./shellcolord {};
  wofi-hyprkeys = pkgs.callPackage ./wofi-hyprkeys {};

  tor-13_5_2 = pkgs.callPackage ./tor-browser {
    tor-version = "13.5.2";
    tor-hash = "sha256-f6bKRWirHuOe2BnCYegZi1j58Ou3p6Syw++NVLGUGdU=";
  };

  tor-14_5 = pkgs.callPackage ./tor-browser {
    tor-version = "14.5";
    tor-hash = "sha256-wSxmNPPJsLRjDVimc2Rp1rBcIgYp/CtPKuU6+gZfVmw=";
  };
  # wezterm-nightly = pkgs.callPackage ./wezterm-nightly { };
  # iso = pkgs.callPackage ./iso { inherit inputs pkgs; };
}
