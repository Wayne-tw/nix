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
      # to build vterm
      cmake
      libtool
  ];
  # TODO .Doomemacs Installation
  
  # FIXME .Doomemacs Configuration
  # https://discourse.nixos.org/t/advice-needed-installing-doom-emacs/8806/4
  #home.file.".doom.d" = {
  #  source = builtins.fetchGit "https://github.com/MatthiasScholzTW/doom-emacs-config.git";
  #  recursive = true;
  #  # TODO onChange = readFile path/to/reload;
  #};

  programs.zsh.initExtra = ''
    # TODO Check if doomemacs already provides this functionality somehow, via :os tty
    # Use vterm provide configuration files to configure integration
    # https://github.com/akermu/emacs-libvterm?tab=readme-ov-file#shell-side-configuration-files
    if [[ "$INSIDE_EMACS" = 'vterm' ]] \
      && [[ -n $\{EMACS_VTERM_PATH\} ]] \
      && [[ -f $\{EMACS_VTERM_PATH\}/etc/emacs-vterm-zsh.sh ]]; then
  	  source $\{EMACS_VTERM_PATH\}/etc/emacs-vterm-zsh.sh
    fi
    '';
}
