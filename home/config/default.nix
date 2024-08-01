{ config, pkgs, ... }:

{
  imports = [
    ./hypr
    ./emoji.nix
    ./rofi
    ./cava
  ];

  home.file.".config/fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };

  home.file.".config/wlogout" = {
    source = ./wlogout;
    recursive = true;
  };

  home.file."" = {
    source = ./zsh;
    recursive = true;
  };

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };
}
