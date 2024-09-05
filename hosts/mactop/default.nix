{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    # ../common/global/nix.nix
    ../common/global/fish.nix
  ]  ++ (builtins.attrValues outputs.nixosModules);

  networking = {
    hostName = "mactop";
    computerName = "mactop";
    knownNetworkServices = ["Thunderbolt Bridge" "Wi-Fi"];
    dns = ["1.1.1.1" "1.0.0.1"];
  };

  time.timeZone = "Europe/London";

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-darwin";
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  users.users.sjcobb = {
    home = "/Users/sjcobb";
    openssh.authorizedKeys.keys = [(builtins.readFile ../common/users/ssh.pub)];
    packages = [
      pkgs.home-manager
    ];
  };
  
  nix = { 
    package = pkgs.nix;
    settings = {
      trusted-users = ["root"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      system-features = ["big-parallel" "nixos-test" "kvm"];
    };
    gc = {
      automatic = true;
      interval = {
        Day = 1;
      };
      # Delete older generations too
      options = "--delete-older-than 3d";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  fonts.packages = [ pkgs.fira-code-nerdfont ];

  programs.zsh.enable = true;  # default shell on catalina
  services.nix-daemon.enable = true;

  home-manager = {
    users.sjcobb = import ../../home-manager/sjcobb/${config.networking.hostName}.nix;   
    extraSpecialArgs = {inherit inputs outputs;};
  };

  environment.systemPackages = with pkgs; [ alacritty ];

  environment.variables = {
    SHELL = "${pkgs.fish}/bin/fish";
  };

  # system.stateVersion = "23.05";
}
