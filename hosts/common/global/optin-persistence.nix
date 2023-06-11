{ lib, inputs, config, ... }: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;
  
  environment.persistence = {
    "/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager"
        "/var/lib/systemd"
        "/var/lib/nixos"
      ];
    };
  };

 # system.activationScripts.persistent-dirs.text =
 #   let
 #     mkHomePersist = user: lib.optionalString user.createHome ''
 #       mkdir -p /persist/${user.home}
 #       chown ${user.name}:${user.group} /persist/${user.home}
 #       chmod ${user.homeMode} /persist/${user.home}
 #     '';
 #     users = lib.attrValues config.users.users;
 #   in
 #   lib.concatLines (map mkHomePersist users);
}
