

{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gh.nix
    ./shellcolor.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    bottom # System viewer
    ncdu # TUI disk usage
    exa # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
  ];
}
