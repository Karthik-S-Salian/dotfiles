{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "kitty";
    # __GL_VRR_ALLOWED="1";
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # WLR_RENDERER = "vulkan";

    NIXOS_OZONE_WL = "1";
    #WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
    SDL_VIDEODRIVER = "wayland,x11";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    MOZ_ENABLE_WAYLAND = 1;
    HYPRSHOT_DIR = "Pictures/screenshots";
  };
}
