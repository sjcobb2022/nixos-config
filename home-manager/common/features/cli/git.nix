{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      aliases = {
        pushall = "!git remote | xargs -L1 git push --all";
        graph = "log --decorate --oneline --graph";
        add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
      };
      user = {
        name = "Samuel Cobb";
        email = "sjcobb2003@gmail.com";
      };
      extraConfig = {
        feature.manyFiles = true;
        init.defaultBranch = "main";
      };
    };
    ignores = [".direnv" "result" "target"];
  };
}
