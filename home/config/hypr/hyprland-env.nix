{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "kitty";
    # GBM_BACKEND= "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME= "nvidia";
    # __GL_VRR_ALLOWED="1";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";
    CLUTTER_BACKEND = "wayland";
    # WLR_RENDERER = "vulkan";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM="wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    MOZ_ENABLE_WAYLAND = 1;
    };
  };
}