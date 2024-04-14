{ pkgs, ...}: {
  programs.adb.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  environment.systemPackages = with pkgs; [
    android-studio
  ];
  
}
