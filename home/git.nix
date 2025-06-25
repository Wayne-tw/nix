{ pkgs, ... }:
{
  home.file = {
    ".cvsignore".source = ../config/git/.cvsignore;
    ".gitconfig".source = ../config/git/.gitconfig;
  };

  programs.git = {
    enable = true;
  };

  # Manage multiple git repositories
  home.packages = with pkgs; [
    pre-commit
  ];
}
