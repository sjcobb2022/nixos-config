{ config, pkgs, ... }:
{
  # home.sessionVariables.EDITOR = "nvim";
  imports = [
    ./neovide.nix
  ];
  
  programs.neovim = {
    enable = true;
  };

  xdg.configFile."nvim".source = builtins.fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
    ref = "main";
    # rev = "87a05226b003c05369ca70ff7e7baf4910d0f8b1";
    shallow = true;
  };
}
