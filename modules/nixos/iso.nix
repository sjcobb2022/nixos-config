{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
  ];
}
