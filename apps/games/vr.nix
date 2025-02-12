{config, pkgs, input, ...}:

{
  environment.systemPackages = with pkgs; [
    sidequest
    wivrn
#    alvr
  ];

  services.wivrn.enable = true;
  services.wivrn.defaultRuntime = true;
  services.wivrn.package = pkgs.wivrn;

}
