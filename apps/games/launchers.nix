{config, pkgs, input, ...}:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
  lutris
  r2modman
  heroic
  osu-lazer-bin
  modrinth-app
  lunar-client
  ];
}
