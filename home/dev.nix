{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # per project, vcs specific development environment setup
    devenv
  ];

}
