{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    colima
    # TODO move out of project related - this should be consider a core capability
    docker
    docker-buildx
    docker-compose
  ];

}
