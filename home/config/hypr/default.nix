{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland-env.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    waybar
    libnotify
    swww
    wl-clipboard
    kitty
    networkmanagerapplet
    wlogout
    pavucontrol
    killall
    swaynotificationcenter
    cliphist
    brightnessctl
    playerctl
    hyprcursor
    xwaylandvideobridge
    hyprshot
  ];

  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
        # Monitor
        monitor=DP-1,1920x1080@144,0x0,1.2  #DP-1,1920x1080@144,0x0,1 

        #env
        env = XCURSOR_SIZE,16
        env = HYPRCURSOR_SIZE,16
        env = HYPRCURSOR_THEME,Bibata-Modern-Classic
        env = HYPRSHOT_DIR, Pictures/screenshots

        #some may be redundent need to be removed
        env = GDK_BACKEND, wayland, x11
        env = CLUTTER_BACKEND, wayland
        env = QT_QPA_PLATFORM,wayland;xcb
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
        env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
        env = SDL_VIDEODRIVER, x11

        
        exec-once = hyprlock --immediate

        # Fix slow startup
        #hyprland screensharing fix
        #exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user import-environment  WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

        #variables
        $effect="--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2"

        $terminal = kitty
        $fileManager = nemo
        $menu = killall rofi || rofi -show drun -show-icons
  
        # Autostart
        
        exec-once = wl-paste  --watch cliphist store
        #need to be changed
        #exec-once=bash ~/.config/hypr/start.sh

        #exec-once = hyprctl setcursor Bibata-Modern-Classic 24

        exec-once = killall -q swww;sleep .5 && swww-daemon --format xrgb
        exec-once = killall -q waybar;sleep .5 && waybar
        exec-once = killall -q swaync;sleep .5 && swaync
        exec-once = nm-applet --indicator
        #exec-once = sleep 1.5 && swww img ~/test2.jpg $effect
        
        #look and feel
        general { 
          gaps_in = 1
          gaps_out = 5

          border_size = 2

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false 

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false

          layout = dwindle
        }

        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration {
            rounding = 10

            # Change transparency of focused and unfocused windows
            active_opacity = .96
            inactive_opacity = 0.9

            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)

            # https://wiki.hyprland.org/Configuring/Variables/#blur
            blur {
                enabled = true
                size = 3
                passes = 1
                new_optimizations = true
            
                vibrancy = 0.1696
            }
        }

        animations {
            enabled = true

            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            bezier = liner, 1, 1, 1, 1

            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
            animation = borderangle, 1, 180, liner, loop
        }

        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle {
            pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # You probably want this
        }

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master {
            new_status = master
        }

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc { 
            force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
        }

      # layout and input

      # https://wiki.hyprland.org/Configuring/Variables/#input
        input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 2

            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

            touchpad {
                natural_scroll = true
            }
        }

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 4
        }

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        # device {
        #    name = epic-mouse-v1
        #    sensitivity = -0.5
        #}



        ### KEYBINDINGSS ###
        $mainMod = SUPER

        bind = $mainMod, RETURN, exec, $terminal
        bind = $mainMod, T, exec, $terminal
        bind = $mainMod, Q, killactive,
        bind = $mainMod SHIFT, K, exit,
        bind = $mainMod, B, exec, firefox
        bind = $mainMod, F, exec, $fileManager
        bind = $mainMod, M,fullscreen,
        bind = $mainMod SHIFT, M, togglefloating,
        bindr= $mainMod,Super_L, exec,$menu
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle

        #bind = $mainMod, S, exec, rofi_search # Google search from Rofi
        bind = $mainMod, E, exec, emojipicker

        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        bind = $mainMod SHIFT,right,workspace,e+1
        bind = $mainMod SHIFT,left,workspace,e-1

        # Example special workspace (scratchpad)
        bind = $mainMod, S, togglespecialworkspace, magic
        bind = $mainMod SHIFT, S, movetoworkspace, special:magic

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        bind = ALT,Tab,cyclenext
        bind = ALT,Tab,bringactivetotop
        bind = $mainMod, TAB, workspace, e+1
        #bind = SUPER,Tab,bringactivetotop,

        bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bind = ,XF86AudioPlay, exec, playerctl play-pause
        bind = ,XF86AudioPause, exec, playerctl play-pause
        bind = ,XF86AudioNext, exec, playerctl next
        bind = ,XF86AudioPrev, exec, playerctl previous
        bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
        bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%

        #Screenshot
        bind = $mainMod, PRINT, exec, hyprshot -m window
        bind = , PRINT, exec, hyprshot -m output
        bind = $mainMod SHIFT, PRINT, exec, hyprshot -m region

        bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy


        ### WINDOWS AND WORKSPACES ###

        windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

        windowrulev2 = opacity 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
        windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
        windowrulev2 = noblur,class:^(xwaylandvideobridge)$

        windowrule = float, pavucontrol|blueman-manager
        windowrule=size 600 500,^(pavucontrol)$
        
    '';
  };

  home.file.".config/hypr/colors".text = ''
    $background = rgba(1d192bee)
    $foreground = rgba(c3dde7ee)

    $color0 = rgba(1d192bee)
    $color1 = rgba(465EA7ee)
    $color2 = rgba(5A89B6ee)
    $color3 = rgba(6296CAee)
    $color4 = rgba(73B3D4ee)
    $color5 = rgba(7BC7DDee)
    $color6 = rgba(9CB4E3ee)
    $color7 = rgba(c3dde7ee)
    $color8 = rgba(889aa1ee)
    $color9 = rgba(465EA7ee)
    $color10 = rgba(5A89B6ee)
    $color11 = rgba(6296CAee)
    $color12 = rgba(73B3D4ee)
    $color13 = rgba(7BC7DDee)
    $color14 = rgba(9CB4E3ee)
    $color15 = rgba(c3dde7ee)
  '';
}
