{
  inputs,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    package = inputs.hyprpaper.packages.${pkgs.system}.default;
    enable = true;
    settings = {
      preload = [
        "${../assets/mountain.jpg}"
        "${../assets/wave.png}"
        "${../assets/rocks.jpg}"
      ];
      wallpaper = [
        ",${../assets/mountain.jpg}"
      ];
    };
  };
}
