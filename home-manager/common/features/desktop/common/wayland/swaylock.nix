{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.unstable.swaylock-effects;
    settings = {
      font = "BigBlueTerm437 Nerd Font Mono";
      screenshots = true;
      clock = true;
      fade-in = 0;
      effect-pixelate = 20;

      indicator = true;
      indicator-idle-visible = true;

      ring-color = "00000000";
      ring-ver-color = "00000000";
      ring-wrong-color = "00000000";
      ring-clear-color = "00000000";
      ring-caps-lock-color = "00000000";
      key-hl-color = "00000000";
      text-color = "fff";
      text-ver-color = "ffffff";
      text-clear-color = "ffffff";
      text-caps-lock-color = "ffffff";
      text-wrong-color = "ffffff";
      line-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      inside-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      separator-color = "00000000";
    };
  };
}
