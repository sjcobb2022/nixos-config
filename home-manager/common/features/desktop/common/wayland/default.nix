{ pkgs, ... }:
{
  imports = [
    #./hyprland-vnc.nix
    #./kitty.nix
    ./wezterm.nix
    ./mako.nix
    #./swayidle.nix
    #./swaylock.nix
    ./waybar.nix
    ./kde-polkit-agent.nix
    ./wofi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    grim
    imv
    # mimeo
    # primary-xwayland
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
}
