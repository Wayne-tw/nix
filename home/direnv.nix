{
  config,
  lib,
  pkgs,
  ...
}:

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
  programs.zsh.initContent = ''
    dvd () {
      local readonly TEMPLATE=$1
      echo "use flake \"github:MatthiasScholz/templates?dir=flakes/$TEMPLATE\"" >> .envrc
      direnv allow
    }
  '';
}
