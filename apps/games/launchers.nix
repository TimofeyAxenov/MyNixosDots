{config, pkgs, input, ...}:

let
  archipelago_with_betas = pkgs.archipelago.overrideAttrs (oldAttrs: {
    postInstall = ''
      cp -f /home/timofey/Games/Archipelago_Betas/undertale.apworld ${pkgs.archipelago}/opt/Archipelago/lib/worlds
    '';
  }); 
in {

  programs.steam.enable = true;

  environment.systemPackages = [
  pkgs.lutris
  pkgs.r2modman
  pkgs.gale
  pkgs.heroic
  pkgs.osu-lazer-bin
  pkgs.lunar-client
  pkgs.umu-launcher
  pkgs.moonlight-qt
  pkgs.sunshine
  pkgs.satisfactorymodmanager
  pkgs.scarab
  pkgs.poptracker
  archipelago_with_betas
  pkgs.protonplus
  ];
}
