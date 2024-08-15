{ config, pkgs, lib, ... }:
let
  inherit (import ../modules/variables.nix) gitUsername gitEmail;
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "karthikssalian";
  home.homeDirectory = "/home/karthikssalian";

  # Import Program Configurations
  imports = [
    ./config
    ./scripts
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/karthikssalian/etc/profile.d/hm-session-vars.sh
  #
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
      size = 20;
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
      "application/octet-stream" = "code.desktop";
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

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock --immediate";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
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
