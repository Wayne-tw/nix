{ config, pkgs, lib, ... }:

{
  imports = [
    ./tmux.nix
    ./git.nix
    ./wezterm.nix
  ];

  home = {
    stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      pkgs.devenv
      pkgs.ltex-ls
      pkgs.marksman
      pkgs.nixd
      pkgs.ripgrep
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    #file = {
    #  hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
    #    source = ./../config/hammerspoon;
    #    target = ".hammerspoon";
    #    recursive = true;
    #  };
    #};

    sessionVariables = {
    };
  };

  programs = {
    # Use fish
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # N/A
      '';

      plugins = [
        {
          # TODO: Remove this
          name = "fish-asdf";
          src = pkgs.fetchFromGitHub {
            owner = "rstacruz";
            repo = "fish-asdf";
            rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
            sha256 = "39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c=";
          };
        }
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          };
        }
      ];
    };

    # NOTE Migrated from dotfiles-light
    bash.enable = true;
    zsh.enable = true;
    # Configure colima
    zsh.envExtra = ''
      export DOCKER_HOST=unix://$HOME/.colima/docker.sock
    '';

    zsh.profileExtra = ''
      [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source  ~/.nix-profile/etc/profile.d/nix.sh
      export XCURSOR_PATH=$XCURSOR_PATH:/usr/share/icons:~/.local/share/icons:~/.icons:~/.nix-profile/share/icons
    '';
    zsh.enableCompletion = true;

    # Add convience to init direnv
    # https://discourse.nixos.org/t/bash-functions-home-manager/23087/2
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.initExtra
    # TODO Understand if there is potential to overwrite - since assignment is used
    zsh.initExtra = ''
    dvd () {
      local readonly TEMPLATE=$1
      echo "use flake \"github:MatthiasScholz/templates?dir=flakes/$TEMPLATE\"" >> .envrc
      direnv allow
    }
  
    # FIXME Not working - but plain commands do
    dvt() {
      local readonly TEMPLATE=$1
      nix flake init -t "github:MatthiasScholz/templates#$TEMPLATE"
      direnv allow
    }
  
    # TODO Check if doomemacs already provides this functionality somehow, via :os tty
    # Use vterm provide configuration files to configure integration
    # https://github.com/akermu/emacs-libvterm?tab=readme-ov-file#shell-side-configuration-files
    if [[ "$INSIDE_EMACS" = 'vterm' ]] \
      && [[ -n $\{EMACS_VTERM_PATH\} ]] \
      && [[ -f $\{EMACS_VTERM_PATH\}/etc/emacs-vterm-zsh.sh ]]; then
  	  source $\{EMACS_VTERM_PATH\}/etc/emacs-vterm-zsh.sh
    fi
    '';

    # Define shell aliases
    # TODO Think about how to make dependent on actual use
    #      For now tools are defined as global packages in .fleek.yml
    zsh.shellAliases = {
      # NOTE Defined here because of missing direnv support
      #      Should not harm either - just points nowhere
      # Terraform
      tf = "terraform";
      tfi = "terraform init -upgrade";
      tfp = "terraform plan";
      tfps = "terraform plan -no-color | grep -E '^[[:punct:]]+ resource|~ resource|\+ resource |Plan' | sort";
      # Terramate
      tmg = "terramate generate";
      tmi = "terramate run -- terraform init -upgrade";
      # TODO Incorporate tf-summarize
      #tmp = "terramate run -- sh -c ""pwd && terraform plan""";
      tmp = "terramate run -- terraform plan";
  
      tma = "terramate run -- terraform apply";
      tmaa = "terramate run -- terraform apply -auto-approve";
      tmclone = "terramate experimental clone";
      # Project dependent
      apip = "restish tsp";
      apis = "restish tss";
      apie = "restish tse";
      apil = "restish tsl";
    };

    direnv = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;
    };

    # NOTE Migrated from dotfiles-light
    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "--group-directories-first"
       "--header"
      ];
    };
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };
    atuin.enable = true; 
    zoxide.enable = true;
    dircolors.enable = true;

    starship = {
      enable = true;

      settings = {
        command_timeout = 100;
        format = "[$all](dimmed white)";

        character = {
          success_symbol = "[❯](dimmed green)";
          error_symbol = "[❯](dimmed red)";
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style) )";
        };

        jobs.disabled = true;
      };
    };

    jujutsu = {
      enable = true;
    };
  };
}
