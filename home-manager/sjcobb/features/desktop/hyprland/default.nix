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

  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
  };
}
