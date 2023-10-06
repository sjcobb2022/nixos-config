{ pkgs, ... }:
{
  services.nginx = {
    enable = true;
    streamConfig = ''
      server {
        listen 27017 so_keepalive=on;
        proxy_connect_timeout 2s;
        proxy_pass    stream_mongo_backend;
        proxy_timeout 10m;
      }

      upstream stream_mongo_backend {
        server G683083F1D51ED3-UJ2GE94JAJZME69W.adb.uk-london-1.oraclecloudapps.com:27017;
      }
    '';
  };
}


