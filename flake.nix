{
  description = "Wayne's macOS config with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, flake-utils, ... }: {
    darwinConfigurations = {
      Waynes-MacBook-Pro = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nixpkgs = {
              config.allowUnfree = true;
            };
            system.stateVersion = 6;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              users.wayne = import ./home/home.nix;
            };

            users.users.wayne.home = "/Users/wayne";

            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              autoMigrate = true;
              user = "wayne";
            };
          }
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
