{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./pnpm.nix
    ./shellcolor.nix
    ./starship.nix
    ./zoxide.nix
    ./gpg.nix
  ];

  home.packages = with pkgs; [
    bottom # System viewer
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
