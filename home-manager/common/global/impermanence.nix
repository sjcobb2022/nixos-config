{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: {
 
  imports = [
      inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home = {
    persistence = {
      "/persist/home/${config.home.username}" = {
        directories = [
          "Documents"
          "Pictures"
          "Videos"
          "Music"
          "Downloads"
          "Templates"
          "Public"
          ".local/bin"
          ".local/share/nix"
        ];
        allowOther = true;
      };
    };
  };

}
