{ pkgs, config, ... }:

{
  imports = [
    ./config-search.nix
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = ./theme.rasi;
    plugins = with pkgs;[
      # https://discourse.nixos.org/t/rofi-emoji-plugin-instructions-dont-work-need-help/49696
      (rofi-emoji.override { rofi-unwrapped = rofi-wayland-unwrapped; })
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
    ];
  };
}
