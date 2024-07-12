{
  config,
  pkgs,
  ...
}: {
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
    alejandra
    deadnix
    statix
  ];

  xdg.configFile = {
    "nvim".source = builtins.fetchGit {
      url = "https://github.com/sjcobb2022/lazy.git";
      rev = "ba25fb72fd6fc3c092fc07b6c96d6ac946f4e471";
    };
  };
}
