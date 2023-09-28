

{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gh.nix
    ./pnpm.nix
    ./shellcolor.nix
    ./starship.nix
    ./ssh.nix
  ];
  
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    bottom # System viewer
    ncdu # TUI disk usage
    unstable.eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
  ];

  # home.packages = with pkgs.unstable; [
  #   eza # better ls, temporary whilst as eza is not on stable yet
  # ]
}
