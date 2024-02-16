{ pkgs, ... }:
{
  programs.zoxide = {
    package = pkgs.unstable.zoxide;
    enable = true;
  };
}
