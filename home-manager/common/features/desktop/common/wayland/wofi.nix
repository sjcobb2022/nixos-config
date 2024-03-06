{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  script = pkgs.writeScript "wofi" ''
    #!${pkgs.stdenv.shell}
    JSON=$(hyprkeys --from-ctl --json | jq -r --slurp "[.[]][0]");

    USER_SELECTED=$(echo $JSON | jq -r '.[] | "\(.mods) \(.key) \(.dispatcher) \(.arg)"' | wofi --dmenu -p 'Keybinds' --define "dmenu-print_line_num=true");

    if [ -z "$USER_SELECTED" ]; then
      exit 0;
    fi

    EVENT=$(echo $JSON | jq -r "[.[]] | .[$USER_SELECTED]" | jq -r '"\(.dispatcher) \(.arg)"');

    hyprctl dispatch "$EVENT";
  '';
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
    };
  };
}
