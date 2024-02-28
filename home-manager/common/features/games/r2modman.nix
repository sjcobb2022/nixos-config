{pkgs, ...}: {
  home.packages = with pkgs; [
    unstable.r2modman
  ];
}
