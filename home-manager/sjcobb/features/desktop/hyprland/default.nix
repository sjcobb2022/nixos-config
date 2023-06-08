{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../common/wayland
    inputs.hyprland.homeManagerModules.default
  ];

 # programs = {
 #   fish.loginShellInit = ''
 #     if test (tty) = "/dev/tty1"
 #       exec Hyprland &> /dev/null
 #     end
 #   '';
 #   zsh.loginExtra = ''
 #     if [ "$(tty)" = "/dev/tty1" ]; then
 #       exec Hyprland &> /dev/null
 #     fi
 #   '';
 #   zsh.profileExtra = ''
 #     if [ "$(tty)" = "/dev/tty1" ]; then
 #       exec Hyprland &> /dev/null
 #     fi
 #   '';
 # };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    swaybg
    swayidle
  ];

  # programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
  #  mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  # });

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      # env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1
    '';
  };
}
