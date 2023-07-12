{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-markdown-preview ];
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };
  home.persistence = {
     "/persist/home/sjcobb".directories = [ ".config/gh" ];
  };
}
