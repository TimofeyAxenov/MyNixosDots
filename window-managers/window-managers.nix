{config, libs, pkgs, ...}:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    swayfx
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

}
