/* Rofi Config for Google Search */
{ pkgs, ... }:

{
  home.file.".config/rofi/config-search.rasi".text = ''
    
    @import "~/.config/rofi/config.rasi"

    /* ---- Window ---- */
    window {
        width: 40%;
        y-offset: 6px;
        location: north;
    }

    /* ---- Inputbar ---- */
    inputbar {
        enabled: true;
    }

    /* ---- Mainbox ---- */
    mainbox {
        padding: 0px;
        children: [ "entry"];
    }

    /* ---- Entry ---- */ 
    entry {
        padding: 10px 20px;
        placeholder: "🔎 Google Search";
        text-color: #FFFFFFFF;
        background:     #1E1F29FF;
    }

  '';


  home.packages = with pkgs;[
    (pkgs.writeShellScriptBin "rofi_search" ''
      rofi_config="$HOME/.config/rofi/config-search.rasi"
              
      # Kill Rofi if already running before execution
      if pgrep -x "rofi" >/dev/null; then
          pkill rofi
          exit 0
      fi

      output=$(${pkgs.rofi-wayland}/bin/rofi -dmenu -config "$rofi_config")

      # Check if the output is non-empty
      if [ -n "$output" ]; then
          # URL encode the output and perform the Google search
          query=$(echo "$output" | sed 's/ /%20/g')
          xdg-open "https://www.google.com/search?q=$query"
      fi
    '')
  ];
}

