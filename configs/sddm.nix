{config, inputs, pkgs, ...}:

{
  environment.systemPackages = [(
    pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${~/Pictures/Wallpapers/photo_2024-11-01_18-36-03.jpg}";
      loginBackground = true;
    }
  )];
}
