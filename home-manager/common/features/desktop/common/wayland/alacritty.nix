{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Fira Mono";
        };
      };

      shell = "${pkgs.fish}/bin/fish";

      cursor = {
        style = {
          shape = "Block";
          blinking = "Never";
        };
      };
      window = {
        padding = {
          x = 12;
          y = 12;
        };
      };
      colors = {
        draw_bold_text_with_bright_colors = false;
        primary = {
          background = "0x${palette.base00}";
          foreground = "0x${palette.base05}";
        };
        cursor = {
          text = "0x${palette.base00}";
          cursor = "0x${palette.base05}";
        };
        normal = {
          black = "0x${palette.base00}";
          red = "0x${palette.base08}";
          green = "0x${palette.base0B}";
          yellow = "0x${palette.base0A}";
          blue = "0x${palette.base0D}";
          magenta = "0x${palette.base0E}";
          cyan = "0x${palette.base0C}";
          white = "0x${palette.base05}";
        };
        bright = {
          black = "0x${palette.base03}";
          red = "0x${palette.base08}";
          green = "0x${palette.base0B}";
          yellow = "0x${palette.base0A}";
          blue = "0x${palette.base0D}";
          magenta = "0x${palette.base0E}";
          cyan = "0x${palette.base0C}";
          white = "0x${palette.base07}";
        };
      };
    };
  };
}
