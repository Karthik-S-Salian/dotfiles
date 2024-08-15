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

  rofi_search = pkgs.writeShellScriptBin "rofi_search" ''
  
  rofi_config="$HOME/.config/rofi/config-search.rasi"
      
  # Kill Rofi if already running before execution
  if pgrep -x "rofi" >/dev/null; then
      pkill rofi
      exit 0
  fi

  # Open rofi with a dmenu and pass the selected item to xdg-open for Google search
  # & makes this command run in background
  # this command is blocking
  # https://stackoverflow.com/questions/77333067/why-does-xdg-open-block-on-command-line
    ${pkgs.rofi-wayland}/bin/rofi -dmenu -config "$rofi_config" -p "Search:" | xargs -I{} xdg-open "https://www.google.com/search?q={}" &
  '';

  emojipicker = pkgs.writeShellScriptBin "emojipicker" ''
        # Get user selection via wofi from emoji file.
        chosen= $(cat ~/.config/.emoji | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu -config ~/.config/rofi/config-emoji.rasi | awk '{print $1}')

        # Exit if none chosen.
        [ -z "$chosen" ] && exit
        
        ${pkgs.wl-clipboard}/bin/wl-copy $chosen
        ${pkgs.libnotify}/bin/notify-send "'$chosen' copied to clipboard." &
  '';
in

{
  home.packages = with pkgs;
    [
      wallpaper_random
      rofi_search
      emojipicker
    ];
}
