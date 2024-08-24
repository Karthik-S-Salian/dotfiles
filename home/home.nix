{ config, pkgs, lib, ... }:
let
  inherit (import ../modules/variables.nix) gitUsername gitEmail;
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "karthikssalian";
  home.homeDirectory = "/home/karthikssalian";

  imports = [
    ./config
    ./scripts
  ];

  # home.sessionVariables = {
  #   EDITOR = "emacs";
  #   BROWSER = "${lib.getExe pkgs.firefox}";
  #   TERMINAL = "${lib.getExe pkgs.kitty}";
  # };

  programs.git = {
    enable = true;
    userName = "Karthik-S-Salian";
    userEmail = "karthikssalian5@gmail.com";
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

  # xdg desktopEntries = {
  #     evince = {
  #       name = "Evince";
  #       exec = "${pkgs.evince}/bin/evince";
  #     };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "sublime.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
      "image/png" = "viewnior.desktop";
      "image/jpeg" = "viewnior.desktop";
      "image/webp" = "viewnior.desktop";
      "image/ppm" = "viewnior.desktop";
      "image/avif" = "viewnior.desktop";
      "image/gif" = "viewnior.desktop";
      "image/svg+xml" = "viewnior.desktop";
      "text/plain" = "com.system76.CosmicEdit.desktop";
      # "application/octet-stream" = "code.desktop";
    };
  };

  gtk = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # cursorTheme = {
    #   package = pkgs.vimix-cursor-theme;
    #   name = "vimix-cursor-theme";
    # };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

  };

  #solution for chrome and brave not detecting dark mode
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
