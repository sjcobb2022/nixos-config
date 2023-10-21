{ pkgs, lib, config, ... }: {
  home.packages = [ pkgs.prism-launcher ];

  # home.persistence = {
  #   "/persist/home/${config.home.username}" = {
  #     allowOther = true;
  #     directories = [ ];
  #   };
  # };
}
