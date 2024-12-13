{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    _1password-cli
    # TODO marked as broken
    # _1password-gui
  ];
}
