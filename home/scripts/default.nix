{ pkgs, ... }:

let
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    wallDIR="$HOME/Pictures/wallpapers"

    FORMATS=("jpeg" "png" "gif" "pnm" "tga" "tiff" "webp" "bmp" "farbfeld" "jpg")

    FPS=60
    TYPE="any"
    DURATION=2
    BEZIER=".43,1.19,1,.4"
    SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

    # initiate swww if not running
    swww query || swww-daemon --format xrgb

    PICS=($(find "''${wallDIR}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \)))

    if [ -z "$PICS" ]; then
      echo "Error: No images found in $wallDIR."
      exit 1
    fi

    RANDOM_PIC="''${PICS[$((RANDOM % ''${#PICS[@]}))]}"

    echo $RANDOM_PIC

    swww query && swww img $RANDOM_PIC $SWWW_PARAMS
  '';
in

{
  home.packages = with pkgs;
    [
      wallpaper_random
    ];
}
