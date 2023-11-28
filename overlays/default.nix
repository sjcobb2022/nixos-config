# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    # wezterm-nightly = prev.wezterm.overrideAttrs (oldAttrs: rec {
    #   version = "main";
    #
    #   src = prev.fetchFromGitHub {
    #     owner = "wez";
    #     repo = "wezterm";
    #     rev = "600652583594e9f6195a6427d1fabb09068622a7";
    #     hash = "";
    #   };
    #
    #   cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
    #     name = "wezterm.tar.gz";
    #     inherit src;
    #     outputHash = "";
    #   });
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
