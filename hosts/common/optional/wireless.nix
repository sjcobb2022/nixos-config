{
  config,
  lib,
  ...
}: {
  # Wireless secrets stored through sops

  # networking.networkmanager.enable = false;

  networking.wireless = {
    enable = false;
    fallbackToWPA2 = false;
    # Declarative
    networks = {
      "VM4866900" = {
        psk = "@VM4866900_PASS@";
      };
      "eduroam" = {
        # TODO: get the right identity / pswd and use sops
        authProtocols = ["WPA-EAP"];
        auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          domain_suffix_match="@EDUROAM_DOMAIN@"
          identity="@EDUROAM_IDENT@"
          password="@EDUROAM_PASS@"
          phase2="auth=MSCHAPV2"
        '';
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
