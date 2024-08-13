{pkgs,...}:
{

  home.packages = with pkgs; [
    cinnamon.nemo
    # cinnamon.nemo-fileroller
  ];

  home.file.".local/share/nemo/actions" = {
    source = ./actions;
    recursive = true;
  };
}