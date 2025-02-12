{ config, pkgs, input, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
      gaps.smartGaps = true;
      keybindings = {
        "XF86MonBrightnessDown" = "exec light -U 10";
	"XF86MonBrightnessUp" = "exec light -A 10";
	"XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
	"XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
	"XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
	"${modifier}+r" = "exec wofi --show drun";
      };
      };
  };
}
