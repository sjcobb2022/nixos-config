{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ../common
    ../common/wayland
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    inputs.hyprpaper.packages.${system}.hyprpaper
    inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
    inputs.hyprwm-contrib.packages.${system}.grimblast
    swaybg
    swayidle
    xorg.xprop
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${../common/assets/mountain.jpg}
    preload = ${../common/assets/wave.png}
    preload = ${../common/assets/rocks.jpg}
    wallpaper = ,${../common/assets/mountain.jpg}
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    recommendedEnvironment = true;
    systemdIntegration = true;
    xwayland.enable = true;
    extraConfig = ''
      # nvidia bullshit 
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      # env = GBM_BACKEND,nvidia
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      
      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox
      
      # TODO: use hyprpaper, mako from pkgs
      exec-once = mako
      exec-once = hyprpaper 
      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      
      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf
      
      # sets xwayland scale
      # exec-once=${pkgs.xorg.xprop}/bin/xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1
          
      # toolkit-specific scale
      # env = GDK_SCALE,2
      # env = XCURSOR_SIZE,24
      
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
      
          follow_mouse = 1
      
          touchpad {
              natural_scroll = true 
          }
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          gaps_in = 5
          gaps_out = 20
          border_size = 2
      
          layout = dwindle
      }
      
      animations {
          enabled = true
      
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }
      
      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      misc {
        disable_hyprland_logo = true
        new_window_takes_over_fullscreen = false
      }
      
      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
          workspace_swipe_fingers = 4
      }
      
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      windowrulev2 = float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = pin,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = noinitialfocus,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = size 76 31,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = nofullscreenrequest,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = move 0 0,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
      
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, wezterm
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod SHIFT, W, exec, firefox
      bind = $mainMod, E, exec, thunar 
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, D, exec, pkill wofi || wofi -S drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      bind = $mainMod, F, fullscreen
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod CTRL, left, movewindow, l
      bind = $mainMod CTRL, right, movewindow, r
      bind = $mainMod CTRL, up, movewindow, u
      bind = $mainMod CTRL, down, movewindow, d
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

      bindel=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      bindel=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      bindel=,XF86MonBrightnessUp,exec,light -A 10
      bindel=,XF86MonBrightnessDown,exec,light -U 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # use main mod alt to move around workspaces
      # we use relative workspaces here to make it easier to
      bind = $mainMod ALT, left, workspace, r-1
      bind = $mainMod ALT, right, workspace, r+1
      bind = $mainMod ALT, up, workspace, r+1
      bind = $mainMod ALT, down, workspace, r-1

      # use mainMod shift to move (shift haha) an actiuve window 
      bind = $mainMod SHIFT, left, movetoworkspacesilent, r-1
      bind = $mainMod SHIFT, right, movetoworkspacesilent, r+1
      bind = $mainMod SHIFT, up, movetoworkspacesilent, r+1
      bind = $mainMod SHIFT, down, movetoworkspacesilent, r-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };

}
