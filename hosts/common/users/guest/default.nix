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
      "git"
    ];

    openssh.authorizedKeys.keys = [ (builtins.readFile ../ssh.pub) ];
    # passwordFile = config.sops.secrets.misterio-password.path;
    packages = [ 
      pkgs.home-manager
    ];
  };

  # sops.secrets.misterio-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };

  home-manager.users.guest= import ../../../../home-manager/guest/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;

  # security.pam.services = { swaylock = { }; };
}
