{ config, pkgs, lib, inputs, ... }:

{
  # NixOS system-wide home-manager configuration
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home-manager.darwinModules.home-manager.home = {
    packages = with pkgs; [
      # Needed to benefit of nix-sops module
      # age
    ];
  };

}
