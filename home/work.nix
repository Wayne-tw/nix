{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    colima
    docker
    docker-buildx
    docker-compose
    mermaid-cli
    k9s
    awscli2
    terramate
  ];
}
