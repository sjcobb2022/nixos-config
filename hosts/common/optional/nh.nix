{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nh.nixosModules.default];

  nh = {
    enable = true;
  };
}
