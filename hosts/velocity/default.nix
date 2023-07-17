
{ pkgs, inputs, config, lib, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.omen-en00015p

    ./hardware-configuration.nix
    ../common/global
    ../common/users/sjcobb
    ../common/optional/grub.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;

  networking = {
    hostName = "velocity";
    domain = "";
  };

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrk0T7LSF+LZ4mF3CdbVBp8Qcty9osSMkZZEm4rqy5tDqgHmd4SNr2KXDTENBAdo5Z4Ihdy5eXS/Q2OiBu9oWrVXpkEANb2LXIH3W3Af1q4U/72zTP+jCrpEj//2eULCeq7KcCiAmD6LekGMGqvUC5mHYw85LUWU5Jx+b5gXSQyzDozw35TRxGtjtEXs5fwAT0lXLwhzJWV4Su8pGaCd2NC6zZ38fcfISv8qjo8alKxxX+ZoUaXqGsm/ZedrmN3csjcxGuS7tekmstvoK/SEx7inwLWbpu6877Sj9AuGEG8hX0ASm4brkW4UsjOjNQjOmYjdOkVmHSE0P/2/modEv1 ssh-key-2023-07-17''
  ];

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  
  system.stateVersion = "23.05";
} 
