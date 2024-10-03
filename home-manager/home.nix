{ inputs, config, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "timofey";
  home.homeDirectory = "/home/timofey";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName = "User";
    userEmail = "timofeyaxenov@yandex.ru";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ags = {
    enable = true;

    configDir = /home/timofey/.config/ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/timofey/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    HYPRCURSOR_THEME = "McMojave";
    HYPRCURSOR_SIZE = 24;
  };

#  home.pointerCursor = 
#    let 
#      getFrom = url: hash: name: {
#          gtk.enable = true;
#          x11.enable = true;
#          name = name;
#          size = 48;
#          package = 
#            pkgs.runCommand "moveUp" {} ''
#              mkdir -p $out/share/icons
#              ln -s ${pkgs.fetchzip {
#                url = url;
#                hash = hash;
#              }} $out/share/icons/${name}
#          '';
#        };
#    in
#      getFrom 
#        "https://github.com/ful1e5/XCursor-pro/releases/download/v2.0.2/XCursor-Pro-Dark.tar.xz"
#        "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
#        "XCursor-pro";
#
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      "$mod, Q, exec, kitty"
      "$mod, M, exit"
      "$mod, R, exec, wofi --show drun"
      "$mod, C, killactive"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, V, togglefloating"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
    ]
    ++ (
      builtins.concatLists (builtins.genList (i:
        let ws = i+1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      )      
      9)
    );

    monitor = ",preferred,auto,auto";

    decoration = {
      rounding = 10;

      active_opacity = 1.0;
      inactive_opacity = 0.8;

      drop_shadow = false;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };

    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ips = true;
      splash = false;
      

      preload = [
        "/run/media/timofey/BigDisk/Wallpapers/whoami.png"
      ];
      wallpaper = [
        ", /run/media/timofey/BigDisk/Wallpapers/whoami.png"
      ];
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      "ll" = "ls -l";
      ".." = "cd ..";
      "sysrebuild" = "sudo nixos-rebuild switch --flake /home/timofey/.dotfiles";
      "homerebuild" = "home-manager switch --flake /home/timofey/.dotfiles --impure";
    };
    initExtra = "
      cat ~/.cache/wal/sequences
      source ~/.cache/wal/colors-tty.sh
      
    ";
  };
}
