{ pkgs, config, ... }:

{
  imports = [
    ./config-emoji.nix
    ./config-search.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = ./theme.rasi;
  };
}
