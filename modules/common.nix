{ pkgs, config, inputs, ... }:

{
  imports = [
    ./start.nix
    ./fonts.nix
    inputs.home-manager.nixosModules.default
  ];

  # Enable networking
  networking.networkmanager.enable = true;

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

  programs.file-roller.enable = true;

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
    nemo
    vlc
    p7zip
    viewnior
    obs-studio

    nixpkgs-fmt #for vscode nix formatter

    webcord
  ];

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = { };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #WLR_NO_HARDWARE_CURSORS = "1";
  };

  home-manager.backupFileExtension = "bak";

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karthikssalian = {
    isNormalUser = true;
    description = "Karthik S Salian";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
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

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

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

    gnome.gnome-keyring.enable = true;

    fstrim.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
