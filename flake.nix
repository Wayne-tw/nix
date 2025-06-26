{
  description = "Nix System Configuration";

  inputs = {
    # The main nixpkgs instance
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # TODO separate homebrew setup and combine with homebrew usage
    # For installing homebrew
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    # Homebrew Tap Management
    # NOTE: https://github.com/zhaofengli/nix-homebrew?tab=readme-ov-file#declarative-taps
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-sm = {
      url = "github:clok/homebrew-sm";
      flake = false;
    };
    homebrew-gossm = {
      url = "github:gjbae1212/homebrew-gossm";
      flake = false;
    };
    homebrew-awslim = {
      url = "github:fujiwara/homebrew-tap";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      # optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      darwin,
      sops-nix,
      flake-utils,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-sm,
      homebrew-gossm,
      homebrew-awslim,
      ...
    }@inputs:
    let
      nixpkgsConfig = {
        config.allowUnfree = true;
      };
    in
    {
      # NOTE configure automatic backup of existing files
      home-manager.backupFileExtension = "bak";

      darwinConfigurations = {
        "Waynes-MacBook-Pro" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              system.stateVersion = 6;
              home-manager = {
                # FIXME sync with all macosx configurations
                useGlobalPkgs = true;
                # NOTE setting to true will create an unrecognized path for binaries for emacs
                useUserPackages = false;
                users.wayne = import ./home/home.nix;
              };
              users.users.wayne.home = "/Users/wayne";
            }

            # FIXME move inside ./darwin/darwin.nix file if possible - keep the flake short
            # TODO Do this for all MacOSX systems NOT only this single one
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                autoMigrate = true;
                # FIXME use the user name set via darwinConfiguration
                user = "wayne";

                # TODO check if this is necessary
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "clok/homebrew-sm" = homebrew-sm;
                  "gjbae1212/homebrew-gossm" = homebrew-gossm;
                  "fujiwara/homebrew-tap" = homebrew-awslim;
                };
                mutableTaps = false;
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
