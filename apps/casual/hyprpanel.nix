{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    bun
    gnome-bluetooth
    libgtop
    bluez
    wl-clipboard
    dart-sass
    brightnessctl
    python312Packages.gpustat
    power-profiles-daemon
    grimblast
    gpu-screen-recorder
    hyprpicker
    btop
    matugen
    swww
    hyprpanel
  ];
}
