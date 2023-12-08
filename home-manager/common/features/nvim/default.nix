{ config, pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    plugins = with pkgs; [
      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
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

    # "nvim".source = builtins.fetchGit {
    #   url = "https://github.com/LazyVim/starter";
    #   rev = "92b2689e6f11004e65376e84912e61b9e6c58827";
    # };

    "astronvim/lua/user".source = builtins.fetchGit {
      url = "https://github.com/sjcobb2022/astro_config.git";
      ref = "main";
      rev = "f0fb451c9d3198674a6255e3d43ef90b9a681415";
      shallow = true;
    };
  };
}
