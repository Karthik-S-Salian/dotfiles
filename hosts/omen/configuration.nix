# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common.nix
      # ../../modules/game.nix
      ../../modules/hardware-acceleration.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.

  services.xserver.videoDrivers = [ "nvidia" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karthikssalian = {
    isNormalUser = true;
    description = "Karthik S Salian";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "docker"];
    packages = with pkgs; [
    ];
  };


  services.postgresql = {
    enable = true;
    port = 5432;
    # ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    google-chrome
    bun
    nodejs
    gimp
    ffmpeg
    libreoffice
    (python3.withPackages (ps: with ps; [
      jupyter
      pandas
      scikit-learn
      openpyxl
    ]))
  ];

  #https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = true;

    open = false;
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };

  # Just set the console font, don't mess with the font settings
  # console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  # console.earlySetup = true;

  services = {
    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };

  # programs.wayfire = {
  #   enable = true;
  #   plugins = with pkgs.wayfirePlugins; [
  #     wcm
  #     wf-shell
  #     wayfire-plugins-extra
  #   ];
  # };
  
  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
