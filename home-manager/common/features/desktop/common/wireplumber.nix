{
  xdg.configFile = {
    "wireplumber/wireplumber.conf.d/10-disable-camera.conf".text = ''
      wireplumber.profiles = {
        main = {
          monitor.libcamera = disabled
        }
      }     
    '';
  };
}
