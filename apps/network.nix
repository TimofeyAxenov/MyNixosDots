{config, pkgs, inputs, ...}:

{

    environment.systemPackages = [
    pkgs.qbittorrent
    pkgs.tor
    pkgs.tor-browser
    pkgs.spotify
    pkgs.chromium
#    config.programs.spicetify.spicedSpotify
#    nym
    ];
  }
