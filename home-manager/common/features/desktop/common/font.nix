{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.unstable.fira;
    };
  };

  # fallback to japanese
  home.packages = with pkgs; [
    ipafont
    noto-fonts
    source-han-sans
    source-han-serif
    nerd-fonts.jetbrains-mono
    nerd-fonts.bigblue-terminal
  ];
}
