{ config, pkgs, ... }:

{
  imports = [
    ./hypr
    ./rofi
    ./cava
    ./nemo
  ];

  home.file.".config/fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };

  home.file."Pictures/wallpapers/windy_day.jpg" = {
    source = ../wallpapers/windy_day.jpg;
  };

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };

  home.file.".config/swaync" = {
    source = ./swaync;
    recursive = true;
  };

  home.file.".config/swappy" = {
    source = ./swappy;
    recursive = true;
  };

  #https://github.com/nix-community/home-manager/issues/3849
  home.file."/.zshrc" = {
    source = ./zsh/.zshrc;
  };

  home.file."/.p10k.zsh" = {
    source = ./zsh/.p10k.zsh;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
  };
}
