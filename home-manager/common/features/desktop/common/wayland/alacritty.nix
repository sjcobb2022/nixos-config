{ pkgs, ... }: {

  programs.alacritty = {
      enable = true;
      package = pkgs.unstable.alacritty;
  };

}
