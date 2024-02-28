{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.home-manager.impermanence
      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "23.05";
    sessionPath = ["$HOME/.local/bin"];
    persistence = {
      "/persist/home/${config.home.username}" = {
        directories = [
          "Documents"
          "Pictures"
          "Videos"
          "Music"
          "Downloads"
          "Templates"
          "Public"
          ".local/bin"
          ".local/share/nix"
        ];
        allowOther = true;
      };
    };
  };

  colorscheme = inputs.nix-colors.colorSchemes.tokyo-city-terminal-dark;
  home.file.".colorscheme".text = config.colorscheme.slug;

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };
}
