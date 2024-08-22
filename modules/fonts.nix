{pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
      ubuntu_font_family
      liberation_ttf
      noto-fonts-color-emoji

      font-awesome

      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) #"FiraCode"
      navilu-font
    ];

    fontconfig = {
      defaultFonts = {
        # serif = [ "Noto Sans CJK" "Navilu" ];
        # sansSerif = [ "Noto Serif CJK" "Navilu" ];
        serif = [ "Liberation Serif" "Navilu" ];
        sansSerif = [ "Ubuntu" "Navilu" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" "Navilu" ];
      };
    };
  };
}
