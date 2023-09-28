{ pkgs, ... }: {
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

  # fallback to japanese  
  home.packages = with pkgs; [
    ipafont
    noto-fonts
    source-han-sans
    source-han-serif
  ];
}
