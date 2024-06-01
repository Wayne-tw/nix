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
    packages = with pkgs; [
      devenv
      ltex-ls
      marksman
      nixd
      ripgrep
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
      "rebuild" = "darwin-rebuild switch --flake ~/projects/config/dotfiles-slim --refresh";
    };

    # Neo2 Configuration via Karabiner Elements
    file.".config/karabiner/karabiner.json".source = ../config/karabiner/karabiner.json;
  };
}
