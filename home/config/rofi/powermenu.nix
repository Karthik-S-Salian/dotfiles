{ pkgs, ... }:
let
  rofi_powermenu = pkgs.writeShellScriptBin "rofi_powermenu" ''
        theme="$HOME/.config/rofi/powermenu.rasi"

        # CMDs
        lastlogin="`last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7`"
        uptime="`uptime | awk '{print $3}' | awk -F',' '{print $1}'`"
        host=`hostname`

        # Convert uptime to hours and minutes
        hours=$(echo "$uptime" | cut -d: -f1)
        minutes=$(echo "$uptime" | cut -d: -f2)

        uptime="$hours hour(s) and $minutes minute(s)"

        # hibernate="\Uf02ca"
        # shutdown="\Uf0425"
        # reboot="\Uf0709"
        # lock="\U1F512"
        # suspend="\Uf04b2"
        # logout="\Uf0343"

        hibernate="🛌"
        shutdown="⏻"
        reboot="🔄"
        lock="🔒"
        suspend="💤"
        logout="🚪"

        # Rofi CMD
        rofi_cmd() {
          rofi -dmenu \
            -p "$USER@$host" \
            -mesg "Last Login: $lastlogin |  Uptime: $uptime" \
            -theme ''${theme}
        }

        run_rofi() {
          echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
        }

        chosen="$(run_rofi)"

        case $chosen in
            $shutdown)
                systemctl poweroff
                ;;
            $reboot)
                systemctl reboot
                ;;
            $lock)
                echo "inside"
                pidof hyprlock || hyprlock -q --immediate
                ;;
            $suspend)
                systemctl suspend
                ;;
            $logout)
                loginctl kill-session $XDG_SESSION_ID
                ;;
            $hibernate)
                systemctl hibernate
                ;;
        esac
  '';
in
{

  home.packages = with pkgs;
    [
      rofi_powermenu
    ];

  home.file.".config/rofi/powermenu.rasi".text = ''

      configuration {
          show-icons:                 false;
      }

      /*****----- Global Properties -----*****/
      * {
          font:                        "JetBrains Mono Nerd Font 10";
          background:                  #11092D;
          background-alt:              #281657;
          foreground:                  #FFFFFF;
          selected:                    #DF5296;
          active:                      #6E77FF;
          urgent:                      #8E3596;
      }

    * {
        font:                        "JetBrains Mono Nerd Font 12";
        background:     #1E1F29FA;
        background-alt: #282A36FF;
        foreground:     #FFFFFFFF;
        selected:       #32a3adFF;
        active:         #f4ceaaFF;
        urgent:         #FF5555FF;
    }


      /*****----- Main Window -----*****/
      window {
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       1000px;
          x-offset:                    0px;
          y-offset:                    0px;

          padding:                     0px;
          border:                      0px solid;
          border-radius:               20px;
          border-color:                @selected;
          cursor:                      "default";
          background-color:            @background;
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     0px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          children:                    [ "inputbar", "listview", "message" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     20px;
          padding:                     100px 40px;
          background-color:            transparent;
          background-image:            url("/home/karthikssalian/Pictures/wallpapers/Fantasy-Landscape3.png", width);
          children:                    [ "textbox-prompt-colon", "prompt"];
      }

      dummy {
          background-color:            transparent;
      }

      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         " System";
          padding:                     15px;
          border:                      0px 0px 0px 10px;
          border-radius:               100% 100% 0px 100%;
          border-color:                @selected;
          background-color:            @urgent;
          text-color:                  @foreground;
      }
      prompt {
          enabled:                     true;
          padding:                     15px;
          border:                      0px;
          border-radius:               0px 100% 100% 100%;
          border-color:                @selected;
          background-color:            @active;
          text-color:                  @background;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     6;
          lines:                       1;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;
        
          spacing:                     30px;
          margin:                      30px;
          background-color:            transparent;
          cursor:                      "default";
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          padding:                     35px 10px;
          border-radius:               55px;
          background-color:            @background-alt;
          text-color:                  @foreground;
          cursor:                      pointer;
      }
      element-text {
          font:                        "feather bold 32";
          background-color:            transparent;
          text-color:                  inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.5;
      }
      element selected.normal {
          background-color:            var(selected);
          text-color:                  var(background);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     15px;
          border-radius:               0px;
          background-color:            @background-alt;
          text-color:                  @foreground;
      }
      textbox {
          background-color:            inherit;
          text-color:                  inherit;
          vertical-align:              0.5;
          horizontal-align:            0.5;
      }
  '';
}
