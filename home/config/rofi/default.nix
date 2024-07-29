{ pkgs, config, ... }:

{
  imports = [
    ./config-emoji.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./theme.rasi;
  };
}
