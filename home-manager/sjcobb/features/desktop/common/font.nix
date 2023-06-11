{ pkgs, ... }: {
  #home.packages = [
  #  (pkgs.nerdfonts.override { fonts = [ "ProggyClean" "JetBrainsMono" "BigBlueTerminal" "Gohu" "FiraCode" ]; })
  # ];
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
