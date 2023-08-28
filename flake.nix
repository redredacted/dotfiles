{
  description = "Home Manager configuration of popcron";
  
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
    ];

    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        "user@popdesk" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
      nixosConfigurations = {
        "poptop" = nixpkgs.lib.nixosSystem {

          modules = [ 
	    ./configuration.nix 

	    home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;

	      home-manager.users.popcorn = import ./home.nix;
	    }
	  ]; 
	  specialArgs = inputs;
        };
      };
    };
}
