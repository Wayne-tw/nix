{
  description = "Nix System Configuration";

  inputs = {
    # The main nixpkgs instance
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # TODO separate homebrew setup and combine with homebrew usage
    # For installing homebrew
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

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
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-bundle,
    ...
  } @ inputs: let
    nixpkgsConfig = {
      config.allowUnfree = true;
    };
  in {
    darwinConfigurations = {
      "Matthiass-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;

            home-manager = {
              # FIXME sync with all macosx configurations
              useGlobalPkgs = true;
              # NOTE setting to true will create an unrecognized path for binaries for emacs
              useUserPackages = false;
              users.matthias = import ./home/home.nix;
            };
            users.users.matthias.home = "/Users/matthias";
          }

          # FIXME move inside ./darwin/darwin.nix file if possible - keep the flake short
          # TODO Do this for all MacOSX systems NOT only this single one
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              autoMigrate = true;
              # FIXME use the user name set via darwinConfiguration
              user = "matthias";

              # TODO check if this is necessary
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
            };
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
