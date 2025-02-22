# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
      ./drivers/amd.nix
      ./spicetify
      inputs.spicetify-nix.homeManagerModules.default
    ];

  # Bootloader.
#  boot.loader = {
#    efi = {
#      canTouchEfiVariables = true;
#      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
#    };
#    grub = {
#     efiSupport = true;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
#     device = "nodev";
#    };
#  };
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
#  boot.loader.grub.efiInstallAsRemovable = true;

#  boot = {
#    plymouth = {
#      enable = true;
#      theme = "Bsol";
#      themePackages = with pkgs; [
        # By default we would install all themes
#        (MrVivekRajan-Plymouth-Themes.override {
#          selected_themes = [ "Bsol" ];
#        })
#      ];
#    };
#  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.podman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timofey = {
    isNormalUser = true;
    description = "Timofey";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" "video" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
#  nixpkgs.config.allowUnfree = true;

#  nixpkgs.config.allowUnsupportedSystem = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "timofey";
      };
    };
  };

  services.flatpak.enable = true;

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  telegram-desktop
  neovim
  davinci-resolve
  gimp
  git
  kitty
  go
  python3
  wofi
  hyprpaper
  hyprcursor
  nerdfonts
  zig
  gcc
  unzip
  nodejs
  pywal
  google-chrome
#  pgadmin4-desktopmode
#  helix
#  zellij
  neofetch
#  dbeaver-bin
  lshw
#  lazygit
  ripgrep
  fd
  tipp10
  hyprshot
  gparted
  element-desktop
  syncthing
  syncthingtray
  xfce.thunar
#  pgadmin4-desktopmode
  python312Packages.flask
  python312Packages.flask-mail
  python312Packages.flask-security
  python312Packages.setuptools
  python312Packages.pip
  pgadmin4-desktopmode
  python312Packages.passlib
  zsh
  activate-linux
  gnome-tweaks
  ocs-url
  cargo
  nixos-generators
  android-tools
  wezterm
  temurin-jre-bin
  temurin-bin
#  clinfo
  jdk
  prismlauncher
  waybar
  openssl
  spotify
  avahi
  cmake
  distrobox
  python312Packages.zstd
  libgcc
  radarr
  glog
  gnutls
  libmicrohttpd
  elfutils
  ghc
  shellcheck
  libsecret

#  bitwarden-cli
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  programs.seahorse.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    times-newer-roman
    corefonts
    vistafonts
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    temurin-jre-bin
    temurin-bin
    jdk
  ];

  security.polkit.enable = true;

  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5353 9757 ];
  networking.firewall.allowedUDPPorts = [ 9757 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
