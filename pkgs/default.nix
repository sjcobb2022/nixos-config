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

  tor-13_5_7 = pkgs.callPackage ./tor-browser {
    tor-version = "13.5.7";
    tor-hash = "sha256-w+W3J07+7/DERDsX0EubHKZfCr9Bc3dKmnS33UA3sdU=";
  };

  tor-14_0 = pkgs.callPackage ./tor-browser {
    tor-version = "14.0";
    tor-hash = "sha256-RNsTj8/HP10ElIjutYCqp50gN7W7Kz+DA94rkkU/VaI=";
  };

  # wezterm-nightly = pkgs.callPackage ./wezterm-nightly { };
  # iso = pkgs.callPackage ./iso { inherit inputs pkgs; };
}
