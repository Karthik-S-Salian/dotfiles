{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = {
        monitor = "";
        color = "rgba(0, 0, 0, 0.5)";
        path = "~/Pictures/wallpapers/Buildings.png";
        blur_passes = 3;
        blur_size = 8;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      #   input-field = [
      #     {
      #       size = "200, 50";
      #       position = "0, -80";
      #       monitor = "";
      #       dots_center = true;
      #       fade_on_empty = false;
      #       font_color = "rgb(202, 211, 245)";
      #       inner_color = "rgb(91, 96, 120)";
      #       outer_color = "rgb(24, 25, 38)";
      #       outline_thickness = 5;
      #       placeholder_text = "Password...";
      #       shadow_passes = 2;
      #     }
      #   ];
    };

    extraConfig = ''
      # INPUT FIELD
      input-field {
          monitor =
          size = 250, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(0, 0, 0, 0)
          inner_color = rgba(0, 0, 0, 0.5)
          font_color = rgb(200, 200, 200)
          fade_on_empty = false
          #font_family = JetBrains Mono Nerd Font Mono
          placeholder_text = <i><span foreground="##cdd6f4">Password...</span></i>
          hide_input = false
          position = 0, -120
          halign = center
          valign = center
      }

      # TIME
      label {
          monitor =
          text = cmd[update:1000] echo "$(date +"%-I:%M%p")"
          color = rgb(202, 211, 245)
          font_size = 120
          font_family = JetBrains Mono Nerd Font Mono ExtraBold
          position = 0, -300
          halign = center
          valign = top
      }

      # USER
      label {
          monitor =
          text = Welcome, Karthik S Salian  #$USER
          color = rgb(202, 211, 245)
          font_size = 25
          font_family = JetBrains Mono Nerd Font Mono
          position = 0, -40
          halign = center
          valign = center
      }
    
    '';
  };
}
