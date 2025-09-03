{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./auto-upgrade.nix
      ./fish.nix
      ./nix.nix
      ./optin-persistence.nix
      ./openssh.nix
      ./sops.nix
      ./systemd-initrd.nix
      ./acme.nix
      ./yubikey.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  };

  networking = {
    networkmanager = {
      enable = lib.mkDefault true;
      insertNameservers = ["1.1.1.1" "1.0.0.1"];
    };
  };

  # Configure keymap in X11
  # use US keyboard because laptop is in US keyboard layout
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  nix.gc.dates = "daily";

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  environment.enableAllTerminfo = true;
}
