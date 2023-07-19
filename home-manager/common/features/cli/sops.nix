{ inputs, ...}: 
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
