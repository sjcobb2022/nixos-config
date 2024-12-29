{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    plugins = with pkgs; [
      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  home.packages = with pkgs; [
    unzip
    gnumake
    gcc
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
    "nvim".source = inputs.neovim-config.outPath;
    # "nvim".source = builtins.fetchGit {
    #   url = "https://github.com/sjcobb2022/lazy.git";
    #   rev = "57839624ad511af7ac2ef18990c82dfc7e0912db";
    # };
  };
}
