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

  home.file.".config/wlogout" = {
    source = ./wlogout;
    recursive = true;
  };

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };

  home.file.".config/swaync" = {
    source = ./swaync;
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
