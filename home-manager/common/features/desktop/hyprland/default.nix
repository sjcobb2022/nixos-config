{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../common/wayland
    # inputs.hyprland.homeManagerModules.default
  ];

  # services.udev.extraRules = ''
  #   # Your rule goes here
  #   # SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+=""
  #   # SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+=""
  # '';
  #
  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
  ];

  xdg.portal = with pkgs; {
    extraPortals = [inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland];
    configPackages = [wayland.windowManager.hyprland.package];
    xdgOpenUsePortal = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland-patched;
    systemd = {
      enable = true;
      variables = ["--all"];
    };

    xwayland.enable = true;
    settings = {
      monitor = ",highres,auto,auto";

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };

        sensitivity = 0;
      };

      # cursor = {
      #   no_hardware_cursor = true;
      # };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      debug = {
        disable_logs = false;
      };

      animations = {
        enabled = true;
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "windowsMove, 1, 7, myBezier"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        new_window_takes_over_fullscreen = 2;
        key_press_enables_dpms = true;
        vrr = 1;
      };

      decoration = {
        shadow.enabled = false;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
      };

      windowrulev2 = [
        # "float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        # "pin,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        # "noinitialfocus,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        # "size 76 31,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        # "move 0 0,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
      ];

      "$mod" = "SUPER";

      bind = let
        wlogout = lib.getExe pkgs.wlogout;
        wofi = lib.getExe pkgs.wofi;
        alacritty = lib.getExe pkgs.alacritty;
        firefox = lib.getExe pkgs.firefox;
        thunar = lib.getExe pkgs.xfce.thunar;
        grimblast = lib.getExe inputs.hyprwm-contrib.packages.${pkgs.system}.grimblast;
        workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
      in
        [
          "$mod,M,exit,"
          "$mod,Return,exec,${alacritty}"
          "$mod,Q,killactive,"
          "$mod SHIFT,W,exec,${firefox}"
          "$mod,E,exec,${thunar}"
          "$mod,V,togglefloating,"
          "$mod,D,exec,pkill wofi || ${wofi} -S drun"
          "$mod,P,pseudo,"
          "$mod,J,togglesplit,"
          "$mod,escape,exec,pkill wlogout || ${wlogout} -p layer-shell"
          "$mod,F,fullscreen"
          "$mod,K,exec,${pkgs.wofi-hyprkeys}/bin/wofi-hyprkeys"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod CTRL, left, resizeactive, -5% 0"
          "$mod CTRL, right, resizeactive, 5% 0"
          "$mod CTRL, up, resizeactive, 0 -5%"
          "$mod CTRL, down, resizeactive, 0 5%"

          # Scroll through existing workspaces with mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # use main mod alt to move around workspaces
          # we use relative workspaces here to make it easier to
          "$mod ALT, left, workspace, r-1"
          "$mod ALT, right, workspace, r+1"
          "$mod ALT, up, workspace, r+1"
          "$mod ALT, down, workspace, r-1"

          # use mod shift to move (shift haha) an actiuve window
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          ",Print,exec,${grimblast} --notify copy screen"
          "SHIFT,Print,exec,${grimblast} --notify save screen"

          "CTRL,Print,exec,grimblast --notify copy area"
          "CTRL SHIFT,Print,exec,grimblast --notify save area"
        ]
        ++ (map (n: "$mod,${n},workspace,${n}") workspaces)
        ++ (map (n: "$mod SHIFT,${n},movetoworkspacesilent,${n}") workspaces);

      bindel = let
        swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
      in [
        ", XF86AudioRaiseVolume, exec, ${swayosd} --output-volume=raise"
        ", XF86AudioLowerVolume, exec, ${swayosd} --output-volume=lower"
        ", XF86MonBrightnessUp,exec, ${swayosd} --brightness=raise"
        ", XF86MonBrightnessDown,exec, ${swayosd} --brightness=lower"
      ];

      bindl = let
        playerctl = lib.getExe' pkgs.playerctl "playerctl";
        swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
      in [
        ", XF86AudioMute, exec, ${swayosd} --output-volume mute-toggle"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioNext, exec, ${playerctl} next"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
