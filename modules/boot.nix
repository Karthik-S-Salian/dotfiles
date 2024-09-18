#https://wiki.nixos.org/w/index.php?title=Plymouth&mobileaction=toggle_view_desktop
{ pkgs, ... }: {
  boot = {

    # plymouth = {
    #   enable = true;
    #   theme = "rings";
    #   themePackages = with pkgs; [
    #     # By default we would install all themes
    #     (adi1090x-plymouth-themes.override {
    #       selected_themes = [ "rings" ];
    #     })
    #   ];
    # };

    # Enable "Silent Boot"
    # consoleLogLevel = 0;
    # initrd.verbose = false;
    # kernelParams = [
    #   "quiet"
    #   "splash"
    #   "boot.shell_on_fail"
    #   "loglevel=3"
    #   "rd.systemd.show_status=false"
    #   "rd.udev.log_level=3"
    #   "udev.log_priority=3"
    # ];

    loader = {
      timeout = 15;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
