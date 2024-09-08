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
  imports =
    [
      inputs.home-manager.darwinModules.home-manager
      ../common/global/nix.nix
      ../common/global/fish.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

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

  home-manager = {
    users.sjcobb = import ../../home-manager/sjcobb/${config.networking.hostName}.nix;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nix.gc.interval.Day = 1;

  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];})
  ];

  programs.zsh.enable = true; # default shell on catalina
  services.nix-daemon.enable = true;

  environment.systemPackages = with pkgs; [alacritty];

  environment.variables = {
    SHELL = "${pkgs.fish}/bin/fish";
    # Hack to get shellcolord to work.
    XDG_RUNTIME = "/tmp";
  };

  # system.stateVersion = "23.05";
}
