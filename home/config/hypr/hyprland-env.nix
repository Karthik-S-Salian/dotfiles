{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      TERMINAL = "kitty";
      # GBM_BACKEND= "nvidia-drm";
      # __GLX_VENDOR_LIBRARY_NAME= "nvidia";
      # __GL_VRR_ALLOWED="1";
      # LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
      # WLR_NO_HARDWARE_CURSORS = "1";
      # WLR_RENDERER_ALLOW_SOFTWARE = "1";
      # WLR_RENDERER = "vulkan";

      # env = GDK_BACKEND, wayland, x11
      # env = QT_QPA_PLATFORM,wayland;xcb
      # env = SDL_VIDEODRIVER, x11

      CLUTTER_BACKEND = "wayland";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      MOZ_ENABLE_WAYLAND = 1;
      HYPRSHOT_DIR = "Pictures/screenshots";
    };
  };
}
