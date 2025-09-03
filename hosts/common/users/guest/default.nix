{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.guest = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups =
      [
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "git"
      ];

    hashedPassword = "$6$Eg.I6xEM3gwatG1V$E/R99rAkAuH9mwOxh/H9eqHfQEVv7.wDFrYVyyvLC1KF3ktuDxea1uthbOvWH/jjkZGKLV4gDel.zr5U57Y9W0";
    # hashedPasswordFile = config.sops.secrets.guest-password.path;

    openssh.authorizedKeys.keys = [(builtins.readFile ../ssh.pub)];
    packages = [
      pkgs.home-manager
    ];
  };

  # sops.secrets.guest-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.guest = import ../../../../home-manager/guest/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
}
