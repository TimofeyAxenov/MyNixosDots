{config, pkgs, inputs, ...}:

{

    virtualisation.waydroid.enable = true;
    environment.systemPackages = with pkgs; [
    qbittorrent
    tor
    tor-browser
    tauon
    mozillavpn
    nur.repos.ataraxiasjel.waydroid-script
    spotify
#    nym
    ];
  }
