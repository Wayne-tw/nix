{
  description = "Nix System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    darwin,
    flake-utils,
    home-manager,
    ...
  } @ inputs: {
    darwinConfigurations = {
      "Matthiass-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.matthias = import ./home/home.nix;
            };
            users.users.matthias.home = "/Users/matthias";
          }
        ];
        specialArgs = { inherit inputs; };
      };
      "MacBook-Pro-Home" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.matthias = import ./home/home.nix;
            };
            users.users.matthias.home = "/Users/matthias";
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
