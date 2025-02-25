{
  description = "My NixOS setup flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
     # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

#    nix-comfyui.url = "github:dyscorv/nix-comfyui";
  };

  outputs = {self, nixpkgs, home-manager, aagl, hyprpanel, spicetify-nix, ...}@inputs:
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
        inputs.nixvim.nixosModules.nixvim
        ./configs/neovim/nvim.nix
	./apps/casual/hyprpanel.nix
	./apps/wine.nix
	./apps/games/vr.nix
	./window-managers/window-managers.nix
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
#	inputs.nixvim
#	./configs/neovim/nvim.nix
      ];
        };
      };
  };
}

