{ pkgs, config, inputs, ... }:

{
  imports = [
    ./boot.nix
    ./env.nix
    ./start.nix
    ./fonts.nix
    ./sound.nix
    inputs.home-manager.nixosModules.default
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

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

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

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
    obs-studio
    evince
    cosmic-edit

    nixpkgs-fmt #for vscode nix formatter

    nwg-look

    webcord
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.file-roller.enable = true;

  security.pam.services.hyprlock = { };

  home-manager.backupFileExtension = "bak";

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
      "karthikssalian" = import ../home/home.nix;
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.graphics.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    #for enabling trashbin
    gvfs.enable = true;

    power-profiles-daemon.enable = true;

    fstrim.enable = true;
  };

  # qt = {
  #   enable = true;
  #   style = "adwaita-dark";
  #   platformTheme = "gnome";
  # };

  #keyring
  # services.gnome.gnome-keyring.enable = true;
  # programs.seahorse.enable = true; # enable the graphical frontend
  # environment.systemPackages = [ pkgs.libsecret ]; # libsecret api needed
  # security.pam.services.greetd.enableGnomeKeyring = true; # load gnome-keyring at startup

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}