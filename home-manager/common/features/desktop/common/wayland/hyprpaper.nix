{
  services.hyprpaper = {
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
