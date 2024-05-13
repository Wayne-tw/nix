# Dotfiles

This is to describe the barebones development system I use. Supports Intel and Silicon Macs.

## Tasks

- [ ] Add doomemcs configuration
- [ ] Add default browser
- [ ] Support neo2 keyboard layout
- [ ] Add Docker and colima
- [ ] Support touchid for cli
- [ ] Add statusbar
- [ ] Decide for shell fish or zsh

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
