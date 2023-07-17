{ lib, inputs, config, ... }: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;
  
  environment.persistence = {
    "/persist" = {
      directories = [
        "/etc/NetworkManager"
        "/var/lib/systemd"
        "/var/lib/nixos"
        "/var/log"
        "/srv"
      ];
    };
  };
}
