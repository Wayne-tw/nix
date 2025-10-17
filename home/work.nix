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
    tflint
    hcledit
    trivy
    go-task
    adr-tools
    python3
    gnumake

    # To use caching for devenv, you will need to add a trusted user in /etc/nix/nix.custom.conf
    #  trusted-users = root wayne
    # Then restart the mac
    devenv
    # CLI tool to help you manage multiple repositories
    mani
  ];
}
