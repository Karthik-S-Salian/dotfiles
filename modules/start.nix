{ pkgs, ... }:

let
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "karthikssalian";
in

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = initial_session;
    };
  };
}

# { pkgs, ... }:
# {
#   services.greetd = {
#     enable = true;
#     settings = {
#       default_session = {
#         command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
#         user = "karthikssalian";
#       };
#     };
#   };

#   systemd.services.greetd.serviceConfig = {
#     Type = "idle";
#     StandardInput = "tty";
#     StandardOutput = "tty";
#     StandardError = "journal"; # Without this errors will spam on screen
#     # Without these bootlogs will spam on screen
#     TTYReset = true;
#     TTYVHangup = true;
#     TTYVTDisallocate = true;
#   };
# }