# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, inputs, ... }:

{
  imports =
    [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      ../../modules/env.nix
      ../../modules/start.nix
      # ../../modules/fonts.nix
      ../../modules/sound.nix
      inputs.home-manager.nixosModules.default
    ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  nixpkgs.hostPlatform = "x86_64-linux";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karthikssalian = {
    isNormalUser = true;
    description = "Karthik S Salian";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    password = "testiso";
  };

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.file-roller.enable = true;

  security.pam.services.hyprlock = { };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "karthikssalian" = import ../../home/home.nix;
    };
  };


  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    #for enabling trashbin
    gvfs.enable = true;

    power-profiles-daemon.enable = true;

    fstrim.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;



  environment.systemPackages = with pkgs; [
    git
    libinput #also need to disable keyboard

    fastfetch
    btop
    cava

    vim
    fzf
    zoxide
    vscode

    firefox
    vlc
    p7zip
    viewnior
    evince
    cosmic-edit

    google-chrome
    nodePackages.nodejs
    bun
  ];

  # fonts.enableDefaultPackages = true;

  system.stateVersion = "24.05";
}
