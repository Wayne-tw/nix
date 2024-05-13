{pkgs, lib, ...}:
{
  # Emacs
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/emacs.nix
  # https://github.com/nix-community/emacs-overlay
  # https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#nixos
  programs.emacs = {
      enable = true;
  };

  # Doomemacs
  # https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix
  # .Doomemacs Prerequisites
  programs.git.enable = true;
  home.packages = with pkgs; [
      (ripgrep.override {withPCRE2 = true;})
      coreutils
      fd
      binutils
      gnutls
      fd
      imagemagick
      zstd
      sqlite
      editorconfig-core-c
      emacs-all-the-icons-fonts
  ];
  # TODO .Doomemacs Installation
  
  # TODO .Doomemacs Configuration
  # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/4
  home.file.".doom.d" = {
    source = github.com/MatthiasScholzTW/doom-emacs-config.git;
    recursive = true;
    # TODO onChange = readFile path/to/reload;
  };
}
