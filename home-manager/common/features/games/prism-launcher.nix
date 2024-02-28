{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.prismlauncher];

  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [".local/share/PrismLauncher"];
    };
  };
}
