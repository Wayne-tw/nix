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
    # TODO move out of project related - this should be consider a core capability
    colima
    # TODO move out of project related - this should be consider a core capability
    docker
    docker-buildx
    docker-compose
  ];

}
