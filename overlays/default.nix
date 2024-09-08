# This file defines overlays
{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # hyprland = prev.hyprland.override {
    #   aquamarine = prev.aquamarine.override {
    #     libinput = prev.libinput.overrideAttrs (self: super: {
    #       version = "1.26.0";
    #       src = final.fetchFromGitLab {
    #         domain = "gitlab.freedesktop.org";
    #         owner = "libinput";
    #         repo = "libinput";
    #         rev = self.version;
    #         hash = "sha256-mlxw4OUjaAdgRLFfPKMZDMOWosW9yKAkzDccwuLGCwQ=";
    #       };
    #     });
    #   };
    # };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
