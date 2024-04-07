{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config) colorscheme;
  inherit (colorscheme) palette;
in {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    colorSchemes = {
      "${colorscheme.slug}" = {
        foreground = "#${palette.base05}";
        background = "#${palette.base00}";

        ansi = [
          "#${palette.base08}"
          "#${palette.base09}"
          "#${palette.base0A}"
          "#${palette.base0B}"
          "#${palette.base0C}"
          "#${palette.base0D}"
          "#${palette.base0E}"
          "#${palette.base0F}"
        ];
        brights = [
          "#${palette.base00}"
          "#${palette.base01}"
          "#${palette.base02}"
          "#${palette.base03}"
          "#${palette.base04}"
          "#${palette.base05}"
          "#${palette.base06}"
          "#${palette.base07}"
        ];
        cursor_fg = "#${palette.base00}";
        cursor_bg = "#${palette.base05}";
        selection_fg = "#${palette.base00}";
        selection_bg = "#${palette.base05}";
      };
    };
    extraConfig =
      /*
      lua
      */
      ''
        return {
          font = wezterm.font("${config.fontProfiles.monospace.family}"),
          font_size = 12.0,
          color_scheme = '${colorscheme.slug}',
          hide_tab_bar_if_only_one_tab = true,
          window_close_confirmation = "NeverPrompt",
          check_for_updates = false,
          term='wezterm'
        }
      '';
  };
}
