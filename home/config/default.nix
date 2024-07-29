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
}
