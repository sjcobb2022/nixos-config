{ lib, inputs, config, pkgs, ... }: {

  imports = [
    ../common
    ../common/wayland
    # inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
  ];

  xdg.portal = with pkgs; {
    extraPortals = [ inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland ];
    configPackages = [ inputs.hyprland.packages.${system}.hyprland ];
    xdgOpenUsePortal = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${../common/assets/mountain.jpg}
    preload = ${../common/assets/wave.png}
    preload = ${../common/assets/rocks.jpg}
    wallpaper = ,${../common/assets/mountain.jpg}
  '';


  # home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd = {
      enable = true;
    };
    xwayland.enable = true;
    settings = {
      env = [
        # Prioritise first card (which for me is the amd iGPU)
        "WLR_DRM_DEVICES,/dev/dri/card0"
        "XDG_SESSION_TYPE,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      exec-once = with pkgs; [
        "${inputs.hyprpaper.packages.${system}.hyprpaper}/bin/hyprpaper"
        "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

      monitor = ",preferred,auto,1.6";

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
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
        new_is_master = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        new_window_takes_over_fullscreen = 2;
        key_press_enables_dpms = true;
        vrr = 1;
      };

      decoration = {
        drop_shadow = false;
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

      bind = [
        "$mod,Return,exec,wezterm"
        "$mod,Q,killactive,"
        "$mod,M,exit,"
        "$mod SHIFT,W,exec,firefox"
        "$mod,E,exec,thunar"
        "$mod,V,togglefloating,"
        "$mod,D,exec,pkill wofi || wofi -S drun"
        "$mod,P,pseudo,"
        "$mod,J,togglesplit,"
        "$mod,escape,exec,pkill wlogout || wlogout -p layer-shell"
        "$mod,F,fullscreen"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod CTRL, left, resizeactive, -5% 0"
        "$mod CTRL, right, resizeactive, 5% 0"
        "$mod CTRL, up, resizeactive, 0 -5%"
        "$mod CTRL, down, resizeactive, 0 5%"

        #" Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"

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

      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp,exec,light -A 10"
        ", XF86MonBrightnessDown,exec,light -U 10"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

}
