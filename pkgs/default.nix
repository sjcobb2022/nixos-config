# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }:
{
  # example = pkgs.callPackage ./example { };
  shellcolord = pkgs.callPackage ./shellcolord { };
  # wezterm-nightly = pkgs.callPackage ./wezterm-nightly { };
  # iso = pkgs.callPackage ./iso { inherit inputs pkgs; };
}
