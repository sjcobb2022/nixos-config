{ outputs, config, lib, pkgs, ... }:

let
  # Dependencies
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  pgrep = "${pkgs.procps}/bin/pgrep";
  tail = "${pkgs.coreutils}/bin/tail";
  wc = "${pkgs.coreutils}/bin/wc";
  xargs = "${pkgs.findutils}/bin/xargs";
  timeout = "${pkgs.coreutils}/bin/timeout";
  ping = "${pkgs.iputils}/bin/ping";

  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  wofi = "${pkgs.wofi}/bin/wofi";
  light = "${pkgs.light}/bin/light";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        modules-left = [
          # "custom/currentplayer"
          # "custom/player"
        ]
        ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
          "hyprland/workspaces"
          "hyprland/submap"
        ]) ++ [
          # whatever else 
        ];

        modules-center = [
          "hyprland/window"
          #   "pulseaudio"
          #   "battery"
          #   "clock"
        ];

        # modules-right = [
        #   "network"
        #   "tray"
        # ];

        modules-right = [
          "tray"
          "temperature"
          "network"
          "idle_inhibitor"
          "memory"
          "cpu"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
        ];

        clock = {
          interval = 10;
          format = "{:%d/%m %H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
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
          format-icons = [ "" ];
        };

        memory = {
          format = "{icon} {}%";
          format-icons = [ "󰍛" ];
          states = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        temperature = {
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
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
          interval = 10;
          format = "{icon} {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
        };

        network = {
          interval = 3;
          format = "{icon} {essid} ({signalStrength}%)";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-icons = {
            "wifi" = [ "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
            "ethernet" = [ "󰈀" ];
            "disconnected" = [ "󰌙" ];
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
          format-icons = [ "" ];
          tooltip-format = "{percent}%";
          on-scroll-down = "${light} -A 1";
          on-scroll-up = "${light} -U 1";
        };

        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | ${cut} -d '.' -f1)"
              count="$(${playerctl} -l | ${wc} -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{title}} - {{artist}}", "alt": "{{status}}", "tooltip": "{{title}} - {{artist}} ({{album}})"}' '';
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
        };

        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "{icon} {volume}%  {format_source}";
          "format-bluetooth-muted" = "{icon}    {format_source}";
          "format-muted" = "  {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "וֹ";
            "headset" = "  ";
            "phone" = "";
            "portable" = "";
            "car" = "";
            default = [ "" "" "" ];
          };
          "on-click" = "${pavucontrol}";
          "on-scroll-down" = "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+";
          "on-scroll-up" = "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-";
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
            default = "";
          };
          "persistent-workspaces" = {
            "*" = [ 1 2 3 4 5 ];
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
    style = let inherit (config.colorscheme) colors; in /* css */ ''
      @define-color highlight #${colors.base0D};
      @define-color base1  #${colors.base01};
      @define-color base2  #${colors.base04};
      @define-color warning #${colors.base09};
      @define-color critical #${colors.base08};

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
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #cpu.warning {
          color: @warning;
      }

      #cpu.critical {
          color: @critical;
      }

      #memory {
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

    '';
  };
}
