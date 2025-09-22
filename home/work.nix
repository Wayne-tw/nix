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
    devenv
  ];
}
