{config, pkgs, inputs, ...}:

{

    virtualisation.waydroid.enable = true;
    environment.systemPackages = with pkgs; [
    qbittorrent
    tor
    tor-browser
    tauon
#    nym
    ];
  }
