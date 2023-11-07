{ pkgs, lib, config, ... }:
{
  programs.wlogout = {
    enable = true;
    # base00: "#171D23"
    # base01: "#1D252C"
    # base02: "#28323A"
    # base03: "#526270"
    # base04: "#B7C5D3"
    # base05: "#D8E2EC"
    # base06: "#F6F6F8"
    # base07: "#FBFBFD"
    # base08: "#F7768E"
    # base09: "#FF9E64"
    # base0A: "#B7C5D3"
    # base0B: "#9ECE6A"
    # base0C: "#89DDFF"
    # base0D: "#7AA2F7"
    # base0E: "#BB9AF7"
    # base0F: "#BB9AF7"
    style = let inherit (config.colorscheme) colors; in /* css */ ''
      * {
        background-image: none;
      }
      
      window {
        background-color: alpha(#${colors.base00}, 0.8);
      }
      
      button {
        background-color: #${colors.base00};
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: #${colors.base01};
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
