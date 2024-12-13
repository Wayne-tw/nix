{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    obsidian
    # NOTE service execution is os dependent, hence a piece is in darwin.nix
    ollama
    # Compress pngs to reduce repository footprint
    # NOTE Needs as to be added to a precommit hook:
    # `pre-commit install`
    oxipng
  ];

  # TODO Install some models
  # Obsidian
  # - nomic-embed-text
  # - llama3.1
  # - gemma2
  # Emacs - Might need to be setup in emacs.nix
  # - zephyr
  #

  # FIXME not working, missing homebrew context
  #homebrew = {
  #  casks = [
  #    "obsidian"
  #    "msty"
  #  ];
  #};

}
