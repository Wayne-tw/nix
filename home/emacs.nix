{pkgs, lib, ...}:
{
  # Emacs
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/emacs.nix
  # https://getfleek.dev/docs/overlays
  # https://github.com/nix-community/emacs-overlay
  # https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#nixos
  programs.emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
  };
  # TODO Understand if needed - doomemacs is my sensible default
  # https://github.com/league/chemacs2nix/tree/main
  # https://discourse.nixos.org/t/chemacs2-flake-usage-example/19880
  # TODO Doomemacs Rerequisites
  # TODO Doomemacs Configuration
  # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/4
  #home.file.".doom.d" = {
  #source = github.com/MatthiasScholz/...;
  #recursive = true;
  #onChange = readFile path/to/reload;
  #};
}
