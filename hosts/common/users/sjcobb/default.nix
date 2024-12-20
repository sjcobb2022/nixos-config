{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.sjcobb = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "adbusers"
        "kvm"
        "adbgroup"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "wireshark"
        "git"
        "libvirtd"
        "docker"
        "kvm"
      ];

    openssh.authorizedKeys.keys = [(builtins.readFile ../ssh.pub)];
    hashedPasswordFile = config.sops.secrets.sjcobb-password.path;
    packages = [
      pkgs.home-manager
    ];
  };

  sops.secrets.sjcobb-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.sjcobb = import ../../../../home-manager/sjcobb/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
}
