{config, pkgs, inputs, lib, ...}:

{
  
#    services.zapret = {
#      enable = true;
#      whitelist = [
#        "custom-50-discord"
#        "youtube.com"
#        "youtu.be"
#      ];
#      params = [
#        "--dpi-desync=fake,disorder2"
#        "--dpi-desync-ttl=1"
#        "--dpi-desync-autottl=2"
#      ];
#    };

#    systemd.user.services.peacock = {
#      enable = true;
#      description="Peacock";
#      wantedBy = [ "default.target" ];
#      serviceConfig = {
#        WorkingDirectory="%h/linux-steam-setup";
#        ExecStart="%h/timofey/linux-steam-setup/start.sh";
#      };
#    };

#    networking.wireguard.interfaces = {
#    wg0 = {
#      # Interface settings
#      ips = [ "10.0.0.2/32" ];
#      privateKey = "YNUPjtT/r6aDlJr9YkLbK9xeP9reRrddeFf/ar/phH4=";
#      mtu = 1420;

      # Peer configuration
 #     peers = [{
 #       publicKey = "KJLaZKQBU8rlcU8Lzgk8gRruwf8u3GK/zN5rHRJ7CWk=";
 #       allowedIPs = [ "0.0.0.0/0" ];
 #       endpoint = "homeremotevpn.duckdns.org:51820";
 #       persistentKeepalive = 21;
 #     }];
 #   };
 # };

 networking.nameservers = ["176.99.11.77" "80.78.247.254"];
 networking.networkmanager.dns = lib.mkForce "none";
 networking.useDHCP = false;
networking.dhcpcd.enable = false;


 services.whisparr = {
   enable = true;
   openFirewall = true;
 };

 services.sonarr = {
   enable = true;
   openFirewall = true;
 };

 services.radarr = {
   enable = true;
   openFirewall = true;
 };

    environment.systemPackages = [
    pkgs.qbittorrent
    pkgs.tor
    pkgs.tor-browser
    pkgs.spotify
    pkgs.chromium
    pkgs.wireguard-tools
    pkgs.nftables
    pkgs.cron
    pkgs.whisparr
    pkgs.sonarr
    pkgs.radarr
    pkgs.jackett
    pkgs.protonvpn-gui
#    config.programs.spicetify.spicedSpotify
#    nym
    ];
  }
