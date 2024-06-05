{pkgs, lib, ...}:
{
  # Emacs
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/emacs.nix
  # https://github.com/nix-community/emacs-overlay
  # https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#nixos
  programs.emacs = {
      enable = true;
  };
  # NOTE vterm support requires compilation
  # requires: libtool, brew:libvterm
  # command for compilation:
  # . Ensure existing alias of `glibtool` to `libtool` (part of shell.nix already)
  # . Find path of the emacs module -> run vterm failing compilation within emacs
  # . Compile outside of emacs in the terminal with the <emacs-vterm>/build folder
  # . `cmake -DLIBVTERM_INCLUDE_DIR=/opt/homebrew/Cellar/libvterm/0.3.3/include -DLIBVTERM_LIBRARY=/opt/homebrew/Cellar/libvterm/0.3.3/lib/libvterm.0.dylib ..`
  # . `make`
  # SEE: cmake configuration parameters: https://github.com/akermu/emacs-libvterm/blob/master/CMakeLists.txt

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
      libtool # missing alias to glibtool need for vterm compilation
      #libvterm # not supported on darwin
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
