# Dotfiles

This is to describe the barebones development system I use. Supports Intel and Silicon Macs.

## Tasks

- [ ] Add default browser
- [ ] Support neo2 keyboard layout
- [ ] Add Docker and colima
- [ ] Support touchid for cli
- [ ] Deal with project specific communication tooling: mattermost, ms-teams, zoom
- [ ] Beeper, logseq, draw.io, notion, notion-calendar, spotify
- [ ] Add statusbar
- [ ] Add doomemcs configuration, dotenc, ispell
- [ ] Decide for shell fish or zsh
- [ ] raycast plugins

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

## Bootstrap

### Darwin/Linux

`nix run nix-darwin -- switch --flake github:matthiasscholz/dotfiles-slim`

## Update

### Darwin

`darwin-rebuild switch --flake ~/src/github.com/matthiasscholz/dotfiles-slim`

or leveage the alias

`rebuild`
