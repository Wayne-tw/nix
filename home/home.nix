{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./editor.nix
    ./work.nix
    ./direnv.nix
  ];

  home = {
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nixd
      ripgrep
      tree
      flameshot
    ];

    # FINAL FIX: Declaratively create the Terraform cache directory
    # -------------------------------------------------------------
    file = {
      ".terraform.d/plugin-cache" = {
        source = pkgs.emptyDirectory;                # Standard read/write/execute permissions
      };
    };
    # -------------------------------------------------------------

    shellAliases = {
      "sys-rebuild" = "sudo darwin-rebuild switch --flake ~/nix --refresh";
      "sys-rollback" = "darwin-rebuild switch --rollback";
      "sys-update" = "cd ~/nix && nix flake update";
      "sys-upgrade" = "sys-update && sys-rebuild";
      "sys-optimise" = "nix-store --optimise";
    };
  };
}
