{
  config,
  lib,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Ensure group exists
  users.groups.docker = {};
}
