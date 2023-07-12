{ config, pkgs, ... }:
{
  # home.sessionVariables.EDITOR = "nvim";
  imports = [
    ./neovide.nix
  ];
  
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
    haskell.compiler.ghcHEAD
    stack
    haskell-language-server
    haskellPackages.haskell-debug-adapter
    haskellPackages.ghci-dap
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
       rev = "a9c9b6f87ca32b5e7271280fbaef3a28a8c26bee";
       shallow = true;
     };
  };
}
