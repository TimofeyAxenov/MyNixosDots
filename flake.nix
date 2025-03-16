{
  description = "My NixOS setup flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    nix-comfyui.url = "github:dyscorv/nix-comfyui";
  };

  outputs = {self, nixpkgs, home-manager, aagl, hyprpanel, spicetify-nix, nvf, nixvim, ...}@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in { 
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
	    inputs.nur.overlays.default
#	    inputs.nix-comfyui.overlays.default
          ];
	  config = {
	    allowUnfree = true;
	    allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "spotify"
              ];
	  };
        };
        specialArgs = {inherit inputs; inherit system;};
        modules = [ 
        ./essentials/configuration.nix 
        ./apps/games/aagl/anime-games.nix
        ./apps/games/launchers.nix
        ./apps/casual/organization.nix
	./apps/work/files.nix
	./apps/work/code.nix
        ./apps/network.nix
#	nixvim.nixosModules.nixvim
	nvf.nixosModules.default
        ./configs/neovim/nvf.nix
#	./apps/casual/hyprpanel.nix
	./apps/wine.nix
	./apps/games/vr.nix
	./window-managers/window-managers.nix
	spicetify-nix.nixosModules.default
	./configs/spotify.nix
#	./apps/ai.nix
        ];
      };
    };
    homeConfigurations = {
      timofey = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./configs/home-manager/home.nix 
	./configs/home-manager/terminal.nix
	./window-managers/config/sway.nix
#	spicetify-nix.homeManagerModules.default
#          {
            # spicetify
#            programs.spicetify.enable = true;
#	    programs.spicetufy.

#            nixpkgs.config.allowUnfreePredicate =
#              pkg:
#              builtins.elem (nixpkgs.lib.getName pkg) [
#                "spotify"
#              ];
#          }
#	inputs.nixvim
#	./configs/neovim/nvim.nix
      ];
        };
      };
  };
}

