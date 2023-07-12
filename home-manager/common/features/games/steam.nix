{ pkgs, lib, ... }:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
in
{
  home.packages = with pkgs; [
    steam-with-pkgs
    gamescope
    protontricks
  ];
   home.persistence = {
     "/persist/home/sjcobb" = {
       allowOther = true;
       directories = [
         #TODO: find game directories
       ];
     };
    };
}
