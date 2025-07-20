{config, libs, pkgs, ...}:

{
  programs.hyprland.enable = true;

  programs.niri.enable = true;
#  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    swayfx
    fuzzel
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

}
