{config, pkgs, inputs, ...}:

{
    environment.systemPackages = with pkgs; [
    qbittorrent
    tor
    tor-browser
    tauon
#    nym
    ];
  }
