{pkgs,...}:
{

  home.packages = with pkgs; [
    nemo
    #nemo-fileroller
  ];

  home.file.".local/share/nemo/actions" = {
    source = ./actions;
    recursive = true;
  };
}