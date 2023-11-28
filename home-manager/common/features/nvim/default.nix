{ config, pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    unzip
    gnumake
    gcc
    nodejs
    rustc
    cargo
    python3
    php
    phpPackages.composer
    stylua
    luajitPackages.luarocks-nix
    rnix-lsp
    alejandra
    deadnix
    statix
  ];

  xdg.configFile = {
    "nvim".source = builtins.fetchGit {
      url = "https://github.com/AstroNvim/AstroNvim.git";
      ref = "refs/tags/v3.32.0";
      rev = "43d458135a534beead8f32158c1d9293adb202dc";
      shallow = true;
    };

    "astronvim/lua/user".source = builtins.fetchGit {
      url = "https://github.com/sjcobb2022/astro_config.git";
      ref = "main";
      rev = "d987e1cb8d7b086ae7d1d4d008310e9908b760ef";
      shallow = true;
    };
  };
}
