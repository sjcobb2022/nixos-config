{ pkgs, config, lib, ... }:
{

  sops.secrets.ssl-cert = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  sops.secrets.ssl-cert-key = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  systemd.services.nginx.serviceConfig.ProtectHome = "read-only";
  systemd.services.nginx.serviceConfig.ReadWritePaths = [ "/home/sjcobb/Documents/" ];

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    user = "sjcobb";

    group = "wheel";

    streamConfig = ''

      resolver 194.168.4.100 valid=15s;

      server {
        set $mongo "G683083F1D51ED3-UJ2GE94JAJZME69W.adb.uk-london-1.oraclecloudapps.com:27017";
        listen 27017 so_keepalive=on;
        proxy_connect_timeout 10s;
        # ssl_certificate /home/sjcobb/Documents/cert.pem;
        # ssl_certificate_key /home/sjcobb/Documents/newkey.pem;
        proxy_ssl  on;
        proxy_ssl_certificate /home/sjcobb/Downloads/wallet/ewallet.pem;
        proxy_ssl_certificate_key /home/sjcobb/Downloads/wallet/ewallet.pem;
        proxy_ssl_password_file /home/sjcobb/Downloads/wallet/key_file.txt;
        # proxy_ssl_certificate_key /home/sjcobb/Downloads/wallet/new.key;
        # proxy_ssl_trusted_certificate /home/sjcobb/Documents/test.pem;
        
        # proxy_ssl_verify       on;

        proxy_pass    $mongo;
        proxy_timeout 10m;
      }

      upstream stream_mongo_backend {
        server G683083F1D51ED3-UJ2GE94JAJZME69W.adb.uk-london-1.oraclecloudapps.com:27017;
      }
    '';



  };
}


