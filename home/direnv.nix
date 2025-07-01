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
# usage dvd dotnet, dvd go
# Uses MatthiasScholz templates https://github.com/MatthiasScholz/templates/tree/main
  programs.zsh.initContent = ''
    dvd () {
      local readonly TEMPLATE=$1
      echo "use flake \"github:MatthiasScholz/templates?dir=flakes/$TEMPLATE\"" >> .envrc
      direnv allow
    }
  '';
}
