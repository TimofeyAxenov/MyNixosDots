{
  description = "my first flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
    };
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = {self, nixpkgs, home-manager, aagl, ...}@inputs: 
    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
      extraSpecialArgs = { inherit system; inherit inputs; };
      specialArgs = { inherit system; inherit inputs; };
    in {
      nixosConfigurations.timofeys-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
#        specialArgs = { inherit inputs; };
        inherit specialArgs;
        modules = [
          ./configuration.nix

#          inherit specialArgs;

          {
          imports = [ aagl.nixosModules.default ];
          nix.settings = aagl.nixConfig; # Set up Cachix
          programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
#          programs.anime-games-launcher.enable = true;
#          programs.anime-borb-launcher.enable = true;
          programs.honkers-railway-launcher.enable = true;
          programs.honkers-launcher.enable = true;
#          programs.wavey-launcher.enable = true;
          programs.sleepy-launcher.enable = true;
        }
#        {  # <- # example to add the overlay to Nixpkgs:
#            nixpkgs = {
#              overlays = [
#                (final: prev: {
#                    nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
#                })];};}
        ];
      };
      homeConfigurations = {
        timofey = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
          ./home.nix

#          {
#          wayland.windowManager.hyprland = {
#            enable = true;
#            # set the flake package
#            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
#          };
#        } 
        ];
        };
      };
    };
}
