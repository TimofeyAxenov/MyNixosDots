{ config, pkgs, inputs, ... }:
let
  aagl = import (builtins.fetchTarball {url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
#  sha256 = "sha256:0c3q1zv852jx8i3xq1jfaxbf2n2g0c8v9n6f4w31z7izxjf5pk4s";
});
  #aagl = inputs.aagl;
in
{
  imports = [
    aagl.module
  ];

  nix.settings = aagl.nixConfig;

  programs.honkers-railway-launcher = {
    enable = true;
  #  package = inputs.aagl.packages.x86_64-linux.honkers-railway-launcher; # for flakes
  };

  programs.honkers-launcher = {
    enable = true;
  #  package = inputs.aagl.packages.x86_64-linux.honkers-launcher; # for flakes
  };

  programs.anime-game-launcher = {
    enable = true;
  #  package = inputs.aagl.packages.x86_64-linux.anime-game-launcher; # for flakes
  };

  programs.wavey-launcher = {
    enable = true;
  #  package = inputs.aagl.packages.x86_64-linux.wavey-launcher; # for flakes
  };

  programs.sleepy-launcher = {
    enable = true;
  #  package = inputs.aagl.packages.x86_64-linux.sleepy-launcher; # for flakes
  };
}
