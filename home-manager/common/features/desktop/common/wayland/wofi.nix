{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  wofi = pkgs.unstable.wofi.overrideAttrs (oa: {
    patches = oa.patches or [];
  });

  pass = config.programs.password-store.package;
  passEnabled = config.programs.password-store.enable;
  pass-wofi = pkgs.pass-wofi.override {inherit pass;};
in {
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      display_generic = true;
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      term = "wezterm";
      terminal = "wezterm";
    };
  };
}
