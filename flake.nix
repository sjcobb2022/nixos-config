{
  description = "NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    stylix.url = "github:danth/stylix";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ###
    # Unstable
    ###

    aquamarine = {
      url = "github:hyprwm/aquamarine";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/hyprland";
      # rev = "604eb21a7e55d85ec7f6cb8cba39fc4c20a07a9d";
      # rev = "f642fb97df5c69267a03452533de383ff8023570";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.aquamarine.follows = "aquamarine";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprkeys = {
      url = "github:hyprland-community/hyprkeys";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    neovim-config = {
      url = "github:sjcobb2022/lazy";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs;};
      };

    mkHome = modules: pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
      };
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    templates = import ./templates;

    formatter = forEachPkgs (pkgs: pkgs.alejandra);

    overlays = import ./overlays {inherit inputs outputs;};

    # Also setup iso installs with nixos generators
    packages = forEachPkgs (
      pkgs:
        (import ./pkgs {inherit pkgs;})
        // (import ./generators {
          inherit pkgs inputs outputs;
          specialArgs = {inherit inputs outputs;};
        })
    );

    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      slaptop = mkNixos [./hosts/slaptop];
      velocity = mkNixos [./hosts/velocity];
      iso = mkNixos [./hosts/iso];
    };

    homeConfigurations = {
      "sjcobb@slaptop" = mkHome [./home-manager/sjcobb/slaptop.nix] nixpkgs.legacyPackages."x86_64-linux";
      "sjcobb@velocity" = mkHome [./home-manager/sjcobb/velocity.nix] nixpkgs.legacyPackages."x86_64-linux";
      "guest@slaptop" = mkHome [./home-manager/guest/slaptop.nix] nixpkgs.legacyPackages."x86_64-linux";
    };
  };
}
