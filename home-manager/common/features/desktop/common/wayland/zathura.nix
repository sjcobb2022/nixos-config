{config, ...}: let
  inherit (config.colorscheme) palette;
in {
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["zathura.desktop"];
  };

  programs.zathura = {
    enable = true;
    # options = {
    #   selection-clipboard = "clipboard";
    #   font = "${config.fontProfiles.regular.family} 12";
    #   recolor = true;
    #   default-bg = "#${palette.base00}";
    #   default-fg = "#${palette.base01}";
    #   statusbar-bg = "#${palette.base02}";
    #   statusbar-fg = "#${palette.base04}";
    #   inputbar-bg = "#${palette.base00}";
    #   inputbar-fg = "#${palette.base07}";
    #   notification-bg = "#${palette.base00}";
    #   notification-fg = "#${palette.base07}";
    #   notification-error-bg = "#${palette.base00}";
    #   notification-error-fg = "#${palette.base08}";
    #   notification-warning-bg = "#${palette.base00}";
    #   notification-warning-fg = "#${palette.base08}";
    #   highlight-color = "#${palette.base0A}";
    #   highlight-active-color = "#${palette.base0D}";
    #   completion-bg = "#${palette.base01}";
    #   completion-fg = "#${palette.base05}";
    #   completions-highlight-bg = "#${palette.base0D}";
    #   completions-highlight-fg = "#${palette.base07}";
    #   recolor-lightcolor = "#${palette.base00}";
    #   recolor-darkcolor = "#${palette.base06}";
    # };
  };
}
