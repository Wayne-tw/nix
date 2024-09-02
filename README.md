# Dotfiles

This is to describe the bare-bones development system I use. Supports Intel and Silicon Macs.

## Tasks

- [x] Add default browser
- [x] Support neo2 keyboard layout
- [x] Add ~/bin into PATH - used by direnv: tfswitch
- [x] Deal with project specific communication tooling: mattermost, ms-teams, zoom
- [x] Unfree: Beeper, logseq, draw.io, notion, notion-calendar, spotify
- [x] Decide for shell fish or zsh -> zsh
- [x] Add opt/homebrew/bin/ to PATH
- [ ] Support touchid for cli
- [ ] gossm need file '/Users/matthias/.aws/credentials_temporary'
- [ ] Configure Terraform Provider Cache environment variable
- [ ] Add Docker and colima
- [ ] Add statusbar
- [ ] Add doomemcs configuration, dotenc, ispell
- [ ] raycast plugins
- [ ] logseq plugins
- [ ] restish configuration
- [ ] import old (before fleek) starship configuration
- [ ] Support for installing [Insta360 Link Software](https://www.insta360.com/de/download/insta360-link)

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

## Bootstrap

### Darwin/Linux

`nix run nix-darwin -- switch --flake github:matthiasscholz/dotfiles-slim`

## Update

### Darwin

`rebuild`

## References

- [source](https://github.com/evantravers/dotfiles)
- [nix-darwin references, high amount of modules and Neo2](https://github.com/Cu3PO42/gleaming-glacier/tree/master)
- [example configuration: PATH, doomemcs][https://gist.github.com/bsag/552a68a198df04ddbc9ddb7b16b170bf]
- [tutorial setting up nix on mac](https://blog.dbalan.in/blog/2024/03/25/boostrap-a-macos-machine-with-nix/index.html)
