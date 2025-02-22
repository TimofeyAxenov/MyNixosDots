{config, pkgs, inputs, ...}:

{

    virtualisation.waydroid.enable = true;
    environment.systemPackages = [
    pkgs.qbittorrent
    pkgs.tor
    pkgs.tor-browser
    pkgs.tauon
    pkgs.mozillavpn
    pkgs.nur.repos.ataraxiasjel.waydroid-script
    pkgs.spotify
#    config.programs.spicetify.spicedSpotify
#    nym
    ];
  }
