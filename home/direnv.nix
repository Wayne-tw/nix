{ config, lib, pkgs, ... }:

{
  programs.direnv = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };

  # Add convience to init direnv
  # https://discourse.nixos.org/t/bash-functions-home-manager/23087/2
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.initExtra
  # TODO Understand if there is potential to overwrite - since assignment is used
  programs.zsh.initExtra = ''
    dvd () {
      local readonly TEMPLATE=$1
      echo "use flake \"github:MatthiasScholz/templates?dir=flakes/$TEMPLATE\"" >> .envrc
      direnv allow
    }

    # FIXME Not working - but plain commands does
    dvt() {
      local readonly TEMPLATE=$1
      nix flake init -t "github:MatthiasScholz/templates#$TEMPLATE"
      direnv allow
    }
  '';
 
}
