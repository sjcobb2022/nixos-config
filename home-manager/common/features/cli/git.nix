{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    };
    userName = "Samuel Cobb";
    userEmail = "sjcobb2003@gmail.com";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
    ignores = [".direnv" "result"];
  };
}
