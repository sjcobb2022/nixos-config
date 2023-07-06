{ pkgs, config, ...}:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # users.mutableUsers = false;
  users.users.sjcobb = {
    initialPassword = "nixos";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "networkmanager"
      "wireshark"
      "git"
      "libvirtd"
    ];

    # openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home-manager/sjcobb/ssh.pub) ];
    # passwordFile = config.sops.secrets.misterio-password.path;
    packages = [ 
      pkgs.home-manager
    ];
  };

  # sops.secrets.misterio-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.sjcobb = import ../../../../home-manager/sjcobb/${config.networking.hostName}.nix;

  # security.pam.services = { swaylock = { }; };
}
