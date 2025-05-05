{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # FIXME not available for darwin anymore
    #zoom-us
  ];

}
