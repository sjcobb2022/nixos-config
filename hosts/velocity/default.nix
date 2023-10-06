{ pkgs, inputs, config, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/users/sjcobb
    ../common/optional/nginx.nix
    # ../common/optional/grub.nix
  ];

  zramSwap.enable = true;

  networking = {
    hostName = "velocity";
    domain = "";
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrk0T7LSF+LZ4mF3CdbVBp8Qcty9osSMkZZEm4rqy5tDqgHmd4SNr2KXDTENBAdo5Z4Ihdy5eXS/Q2OiBu9oWrVXpkEANb2LXIH3W3Af1q4U/72zTP+jCrpEj//2eULCeq7KcCiAmD6LekGMGqvUC5mHYw85LUWU5Jx+b5gXSQyzDozw35TRxGtjtEXs5fwAT0lXLwhzJWV4Su8pGaCd2NC6zZ38fcfISv8qjo8alKxxX+ZoUaXqGsm/ZedrmN3csjcxGuS7tekmstvoK/SEx7inwLWbpu6877Sj9AuGEG8hX0ASm4brkW4UsjOjNQjOmYjdOkVmHSE0P/2/modEv1 ssh-key-2023-07-17''
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUoG/caCzWwxUi+GmI5BqwZHWvO0gslGF1KJMM1jJFYG1tL/6qUfO6DXHtKiVEDykihSUnT+MFv8cEgTqtJaIraeu/8Z2zfkt8FiV5MJcdO16WjIgsBVSqjMImX7TGXZgbYySWtOCTgVCgF22/gc9nZo1DqJxcK9L5Usx6eHxB2FwlRi4KAhFQSdbfI9McMOtk49kgWbNi1peK/pk3y1qp44X4hEZXb4I6tIvFEstgVV5pJEgCt7mKw2rC2GahuKw8+m00vepEEZXnGsqJ8qSXXQh/e87axqbCy555n8Sl/7esnJOASqwlohm13DMVJZQbNx0lyM2BSUestnbXZUJdkSIbwqZ4Ad36UuwII2y9EtoW1lTZlLEQYzUYMMkQELvVGrB2b0KO5F8YnVs1HS458Sk6A8qiJu2TrcqoUmQAupsxXw/z8LwbXrFzqsdUEJ5MWJ6pxd3XFD7OpWwPUl2JYh8jCrCsTJqLuYCBe8842IqUVnaqhfI9astERD+bLWU= sjcobb@slaptop''
  ];

  users.users.sjcobb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrk0T7LSF+LZ4mF3CdbVBp8Qcty9osSMkZZEm4rqy5tDqgHmd4SNr2KXDTENBAdo5Z4Ihdy5eXS/Q2OiBu9oWrVXpkEANb2LXIH3W3Af1q4U/72zTP+jCrpEj//2eULCeq7KcCiAmD6LekGMGqvUC5mHYw85LUWU5Jx+b5gXSQyzDozw35TRxGtjtEXs5fwAT0lXLwhzJWV4Su8pGaCd2NC6zZ38fcfISv8qjo8alKxxX+ZoUaXqGsm/ZedrmN3csjcxGuS7tekmstvoK/SEx7inwLWbpu6877Sj9AuGEG8hX0ASm4brkW4UsjOjNQjOmYjdOkVmHSE0P/2/modEv1 ssh-key-2023-07-17''
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUoG/caCzWwxUi+GmI5BqwZHWvO0gslGF1KJMM1jJFYG1tL/6qUfO6DXHtKiVEDykihSUnT+MFv8cEgTqtJaIraeu/8Z2zfkt8FiV5MJcdO16WjIgsBVSqjMImX7TGXZgbYySWtOCTgVCgF22/gc9nZo1DqJxcK9L5Usx6eHxB2FwlRi4KAhFQSdbfI9McMOtk49kgWbNi1peK/pk3y1qp44X4hEZXb4I6tIvFEstgVV5pJEgCt7mKw2rC2GahuKw8+m00vepEEZXnGsqJ8qSXXQh/e87axqbCy555n8Sl/7esnJOASqwlohm13DMVJZQbNx0lyM2BSUestnbXZUJdkSIbwqZ4Ad36UuwII2y9EtoW1lTZlLEQYzUYMMkQELvVGrB2b0KO5F8YnVs1HS458Sk6A8qiJu2TrcqoUmQAupsxXw/z8LwbXrFzqsdUEJ5MWJ6pxd3XFD7OpWwPUl2JYh8jCrCsTJqLuYCBe8842IqUVnaqhfI9astERD+bLWU= sjcobb@slaptop''
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 5173 4173 80 443 ];
  };


  nix.settings.auto-optimise-store = false;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  system.stateVersion = "23.05";
} 
