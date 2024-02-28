{
  pkgs,
  lib,
  config,
  ...
}: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${config.home.username}/Music";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "pipewire_output"
        }
    '';
  };
}
