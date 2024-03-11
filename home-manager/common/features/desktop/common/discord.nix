{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  home.packages = with pkgs; [unstable.discord unstable.discocss];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/discord"];
  };
}
