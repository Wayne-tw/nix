{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    zoom-us
    slack
    colima
    docker
    docker-buildx
    docker-compose
    teams
    obsidian
    raycast
    mermaid-cli
    k9s
    iterm2
    jetbrains.idea-ultimate
  ];
}
