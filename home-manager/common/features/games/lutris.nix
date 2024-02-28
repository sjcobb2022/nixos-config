{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.lutris];

  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        {
          # Use symlink, as games may be IO-heavy
          directory = "Games/Lutris";
          method = "symlink";
        }
        ".config/lutris"
        ".local/share/lutris"
      ];
    };
  };
}
