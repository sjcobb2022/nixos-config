{pkgs, ...}: {
  home.packages = with pkgs; [ unstable.mcpelauncher-ui-qt unstable.mcpelauncher-client ];
}
