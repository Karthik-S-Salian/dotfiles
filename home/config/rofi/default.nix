{ pkgs, config, ... }:

{
  imports = [
    ./config-search.nix
    ./powermenu.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = ./theme.rasi;
    plugins = with pkgs;[
      rofi-emoji-wayland
      # https://discourse.nixos.org/t/rofi-emoji-plugin-instructions-dont-work-need-help/49696
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
    ];
  };
}
