{ pkgs, config, lib, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # users.mutableUsers = false;
  users.users.guest = {
    initialPassword = "nixos";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "networkmanager"
      "git"
    ];

    openssh.authorizedKeys.keys = [ (builtins.readFile ../ssh.pub) ];
    packages = [
      pkgs.home-manager
    ];
  };

  home-manager.users.guest = import ../../../../home-manager/guest/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;

}
