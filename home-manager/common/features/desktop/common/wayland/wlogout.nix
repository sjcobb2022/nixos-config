{ pkgs, lib, config, ... }:
let
  inherit (config) colorscheme;
  inherit (colorscheme) palette;
in
{
  programs.wlogout = {
    enable = true;
    style = /* css */ ''
      * {
        background-image: none;
      }
      
      window {
        background-color: alpha(#${palette.base00}, 0.8);
      }
      
      button {
        background-color: #${palette.base00};
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: #${palette.base01};
      }

      #lock {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/lock.png}"), url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/logout.png}"), url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/suspend.png}"), url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/hibernate.png}"), url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/shutdown.png}"), url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        opacity: 0.8;
        background-image: image(url("${../assets/wlogout/icons/reboot.png}"), url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
