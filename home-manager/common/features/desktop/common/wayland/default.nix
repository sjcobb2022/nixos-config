{pkgs, ...}: {
  imports = [
    ./mako.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./polkit-gnome-authentication-agent.nix
    ./wofi.nix
    ./wlogout.nix
    ./zathura.nix
    ./obsidian.nix
    ./poweralertd.nix
    ./alacritty.nix
    ./sway-osd.nix
    ./obs.nix
    ./imv.nix
  ];

  home.packages = with pkgs; [
    waypipe
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland;xcb";
    LIBSEAT_BACKEND = "logind";
    NIXOS_OZONE_WL = 1;
  };

  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
}
