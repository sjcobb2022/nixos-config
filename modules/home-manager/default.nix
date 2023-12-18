# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.

{
  # List your module files here
  fonts = import ./fonts.nix;
  shellcolor = import ./shellcolor.nix;
  xdg-portal = import ./xdg-portal.nix;
  # ssh-agent = import ./ssh-agent.nix;
}
