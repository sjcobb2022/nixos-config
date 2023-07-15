# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # linuxPackages_latest = prev.linuxPackages_latest.extend (linuxSelf: linuxSuper:
    #   let
    #     generic = args: linuxSelf.callPackage (import   args) { };
    #   in
    #   {
    #     nvidiaPackages.stable = generic {
    #       version = "535.54.03";
    #       sha256_64bit = "sha256-RUdk9X6hueGRZqNw94vhDnHwYmQ4+xl/cm3DyvBbQII=";
    #       sha256_aarch64 = "sha256-SUxW/Z8sJJ7bc/yhozTh8Wd2gKLsniJwKmXh1tJwUm8=";
    #       openSha256 = "sha256-dp74UiiZfsQbZbAKHgFkLdRNyYbRlVMF3tIXcxok7FU";
    #       settingsSha256 = "sha256-5yIdOAaYQCQ2CmCayD/a5opoQppjK56s9cDqLmm17ww=";
    #       persistencedSha256 = "sha256-R5WCh09BSPjfifui0ODkCsdIXTowceNjLDq5XHwda08=";
    #     };
    #   });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };


  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
