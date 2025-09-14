{
  description = "Wayne's macOS config with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Taps as pinned inputs (flake=false) so Nix builds an immutable taps-env
    homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
    homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };
    gossm-tap     = { url = "github:gjbae1212/gossm";        flake = false; };
    dojo-osx-tap  = { url = "github:kudulab/homebrew-dojo-osx"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }: {
    darwinConfigurations = {
      Waynes-MacBook-Pro = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };

        modules = [
          # 1) Homebrew manager (installs /opt/homebrew and builds taps-env)
          nix-homebrew.darwinModules.nix-homebrew

          # 2) Your main Darwin config (keep your homebrew brews/casks here)
          ./darwin/darwin.nix

          # 3) Home Manager (optional, as you had)
          home-manager.darwinModules.home-manager

          # 4) Inline glue config
          ({ config, lib, inputs, ... }: {
            nixpkgs.config.allowUnfree = true;
            system.stateVersion = 6;

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              users.wayne = import ./home/home.nix;
            };

            users.users.wayne.home = "/Users/wayne";

            # --- nix-homebrew: IMMUTABLE taps pre-materialized by Nix ---
            nix-homebrew = {
              enable = true;
              user = "wayne";
              enableRosetta = true;
              autoMigrate = true;

              mutableTaps = false;

              # Map "owner/homebrew-repo" -> flake input (flake=false above)
              taps = {
                "homebrew/homebrew-core"    = inputs.homebrew-core;
                "homebrew/homebrew-cask"    = inputs.homebrew-cask;
                "gjbae1212/homebrew-gossm"  = inputs.gossm-tap;
                "kudulab/homebrew-dojo-osx" = inputs.dojo-osx-tap;
              };
            };

            # --- Make Brewfile say "Using ..." instead of "Tapping ..." ---
            homebrew.taps = lib.mkForce (builtins.attrNames config.nix-homebrew.taps);
            homebrew.onActivation.autoUpdate = lib.mkForce false; # avoid git fetch in /nix/store
          })
        ];
      };
    };
  };
}
