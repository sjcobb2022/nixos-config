{
  writeShellScriptBin,
  pkgs,
  jq,
  hyprkeys,
  wofi,
  hyprland,
}:
writeShellScriptBin "wofi-hyprkeys" ''
  #!${pkgs.stdenv.shell}

  JSON=$(${hyprkeys}/bin/hyprkeys --from-ctl --json | ${jq}/bin/jq -r --slurp "[.[]][0]");

  USER_SELECTED=$(echo $JSON | ${jq}/bin/jq -r '.[] | "\(.mods) \(.key) \(.dispatcher) \(.arg)"' | ${wofi}/bin/wofi --dmenu -p 'Keybinds' --define "dmenu-print_line_num=true");

  if [ -z "$USER_SELECTED" ]; then
      exit 0;
  fi

  EVENT=$(echo $JSON | ${jq}/bin/jq -r "[.[]] | .[$USER_SELECTED]" | ${jq}/bin/jq -r '"\(.dispatcher) \(.arg)"');

  ${hyprland}/bin/hyprctl dispatch "$EVENT";
''
