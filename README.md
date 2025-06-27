# Nix

These are the configurations to set up my Mac

This repo is forked from MatthiasScholz I have added my custom configuration. 
## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).


## Bootstrap
```shell
xcode-select --install
cd ~/
clone or download this repo as zip
```
### Darwin/Linux

`sudo nix run nix-darwin -- switch --flake . --refresh`

## Update

### Darwin

`sys-rebuild`

## References

- [source](https://github.com/evantravers/dotfiles)
- [nix-darwin references, high amount of modules and Neo2](https://github.com/Cu3PO42/gleaming-glacier/tree/master)
- [example configuration: PATH, doomemcs][https://gist.github.com/bsag/552a68a198df04ddbc9ddb7b16b170bf]
- [tutorial setting up nix on mac](https://blog.dbalan.in/blog/2024/03/25/boostrap-a-macos-machine-with-nix/index.html)
- [fix: profile.lock: no such file or directory](https://github.com/nix-community/home-manager/issues/3734)
