{
  config,
  pkgs,
  ...
}: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview];
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/gh"];
  };
}
