{pkgs, ...}: {
  services = {
    pcscd.enable = true;
    udev.packages = [pkgs.yubikey-personalization];
  };
}
