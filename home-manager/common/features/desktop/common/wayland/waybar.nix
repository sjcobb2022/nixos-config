{
  outputs,
  config,
  lib,
  pkgs,
  ...
}: let
  # Dependencies
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  light = "${pkgs.light}/bin/light";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in {
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    systemd = {
      enable = true;
    };
    settings = {
      primary = {
        layer = "top";
        position = "top";
        modules-left =
          [
            "clock"
            "mpris"
          ]
          ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
            "hyprland/workspaces"
            "hyprland/submap"
          ]);

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "temperature"
          "network"
          "memory"
          "cpu"
          "pulseaudio"
          "backlight"
          "battery"
        ];

        clock = {
          format = "{:%d/%m %H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "{icon} {usage}% ({load})";
          states = {
            "warning" = 70;
            "critical" = 90;
          };
          format-icons = [""];
        };

        mpris = {
          format = "{status_icon} {title}";
          format-paused = "{status_icon} <i>{title}</i>";
          status-icons = {
            paused = "󰐊";
            playing = "󰏤";
            stopped = "󰓛";
          };

          title-len = 20;
        };

        memory = {
          format = "{icon} {}%";
          format-icons = ["󰍛"];
          states = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        temperature = {
          format = "{icon} {temperatureC}°C";
          format-icons = ["" "" "" "" ""];
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };

        battery = {
          bat = "BAT0";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
        };

        network = {
          interval = 3;
          format = "{icon} {essid} ({signalStrength}%)";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-icons = {
            "wifi" = ["󰤟 " "󰤢 " "󰤥 " "󰤨 "];
            "ethernet" = ["󰈀"];
            "disconnected" = ["󰌙"];
          };
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };

        "backlight" = {
          format = "{icon} {percent}% ";
          format-icons = [""];
          tooltip-format = "{percent}%";
          on-scroll-down = "${light} -A 1";
          on-scroll-up = "${light} -U 1";
        };

        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}%  {format_source}";
          "format-bluetooth-muted" = "{icon}    {format_source}";
          "format-muted" = " ";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            #     "headphone" = "󰋋";
            #     "hands-free" = "󰏳";
            #     "headset" = "󰋎";
            #     "phone" = "";
            #     "portable" = "";
            #     "car" = "";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          # "on-click" = "${pavucontrol}";
          "on-scroll-down" = "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+";
          "on-scroll-up" = "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-";
        };

        tray = {
          spacing = 10;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          all-outputs = true;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
            default = " ";
          };
          "persistent-workspaces" = {
            "*" = [1 2 3 4 5];
          };
        };

        "hyprland/window" = {
          max-length = 50;
        };
      };
    };

    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left

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
    style = let
      inherit (config.colorscheme) palette;
    in
      /*
      css
      */
      ''
        @define-color highlight #${palette.base0D};
        @define-color base1  #${palette.base01};
        @define-color base2  #${palette.base04};
        @define-color warning #${palette.base09};
        @define-color critical #${palette.base08};

        /* -----------------------------------------------------------------------------
         * Base styles
         * -------------------------------------------------------------------------- */

        /* Reset all styles */
        * {
            border: none;
            border-radius: 0;
            min-height: 0;
            margin: 1px;
            padding: 0;
        }

        /* The whole bar */
        #waybar {
            background: transparent;
            color: @base2;
            background-color: @base1;
            font-family: FiraMono;
            font-size: 12px;
        }

        /* Every modules */
        #battery,
        #clock,
        #backlight,
        #cpu,
        #memory,
        #mode,
        #network,
        #pulseaudio,
        #temperature,
        #tray,
        #idle_inhibitor {
            padding:0.5rem 0.6rem;
            margin: 1px 0px;
        }

        /* -----------------------------------------------------------------------------
         * Modules styles
         * -------------------------------------------------------------------------- */

        #battery {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #battery.warning {
            color: @warning;
        }

        #battery.critical {
            color: @critical;
        }

        #battery.warning.discharging {
            color: @warning;
        }

        #battery.critical.discharging {
            color: @critical;
        }

        #cpu.warning {
            color: @warning;
        }

        #cpu.critical {
            color: @critical;
        }

        #memory {
        }

        #mpris {
          margin-right: 0.5rem;
        }

        #memory.warning {
            color: @warning;
         }

        #memory.critical {
            color: @critical;
        }

        #network.disconnected {
            color: @warning;
        }

        #pulseaudio {
            padding-top:6px;
        }

        #pulseaudio.muted {
            color: @highlight;
        }

        #temperature.critical {
            color: @critical;
        }

        #window {
            font-weight: bold;
        }

        #workspaces {
            font-size:13px;
        }

        #workspaces button {
            border-bottom: 1px solid transparent;
            margin-bottom: 0px;
            padding: 0px 5px;
        }

        #workspaces button.active {
            border-bottom: 1px solid  @highlight;
        }

        #workspaces button.urgent {
            border-color: @critical;
            color: @critical;
        }

        #tray {
          color: @base2;
        }

      '';
  };
}
