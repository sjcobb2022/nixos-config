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
}
