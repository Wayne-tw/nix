{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # TODO Find a way to manage these "globally" but outside of dotfiles-slim repository.
    # MS Teams
    teams
    # Slack
    slack
    # VPN client

    # General
    #colima # NOTE requires docker (brew)
    #docker-compose
  ];

}
