{ pkgs, lib, config, ... }: {

  services.mpd = {
    enable = true;
    musicDirectory = "/home/${config.home.username}/Music";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "pipewire_output"
        }
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${config.users.users.${config.home.username}.uid}"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
  };

}
