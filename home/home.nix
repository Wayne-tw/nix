{ config, pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    ./wezterm.nix
    ./direnv.nix
    ./git.nix
    ./emacs.nix
  ];

  home = {
    stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      pkgs.devenv
      pkgs.ltex-ls
      pkgs.marksman
      pkgs.nixd
      pkgs.ripgrep
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    #file = {
    #  hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
    #    source = ./../config/hammerspoon;
    #    target = ".hammerspoon";
    #    recursive = true;
    #  };
    #};

    sessionVariables = {
    };

    shellAliases = {
      "rebuild" = "darwin-rebuild switch --flake github:matthiasscholz/dotfiles-slim --refresh";
    };
  };
}
