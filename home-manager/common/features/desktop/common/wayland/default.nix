{pkgs, ...}: {
  imports = [
    #./hyprland-vnc.nix
    #./kitty.nix
    ./wezterm.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./polkit-gnome-authentication-agent.nix
    ./wofi.nix
    ./wlogout.nix
    ./zathura.nix
    ./obsidian.nix
    ./poweralertd.nix
  ];

  home.packages = with pkgs; [
    grim
    imv
    # mimeo
    # pulseaudio
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    # wl-mirror
    # wl-mirror-pick
    # ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
}
