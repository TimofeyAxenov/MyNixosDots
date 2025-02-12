{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    unrar
    vlc
    onedrive
    jellyfin
    davinci-resolve
    libreoffice
  ];
}
