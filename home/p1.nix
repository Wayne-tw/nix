{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    #teams
    restish
    colima # NOTE requires docker (brew)
    docker-compose
  ];

}
