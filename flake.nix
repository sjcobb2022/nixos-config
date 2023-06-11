{
  description = "NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix.url = "github:mic92/sops-nix";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hyprpaper.url = "github:hyprwm/hyprpaper";
  };

  outputs = { self, nixpkgs, nixos-hardware,  home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

      mkNixos = modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    in
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      templates = import ./templates;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));
      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        slaptop = mkNixos [ ./hosts/slaptop ];
      };

      homeConfigurations = {
        "sjcobb@slaptop" = mkHome [ ./home-manager/sjcobb/slaptop.nix ] nixpkgs.legacyPackages."x86_64-linux";
      };
    };
}
