{ config, pkgs, ... }:

{
  home = {
    shellAliases = {
      # bat --plain for unformatted cat
      catp = "bat -P";
      cat = "bat";
      # replace cd
      cd = "z";
      # HACK Trying to compile vterm for emacs
      glibtool = "libtool";
    };
  };

  # NOTE Not set when a new zsh shell is opened without logout/login as user
  home.sessionPath = [
    # FIXME set the path when respective application gets installed
    "$HOME/bin" # tfswitch
    "$HOME/go/bin" # go
  ];


  programs = {
    # Helper
    # .Replacement for 'ls'
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
       "--header"
      ];
    };
    # .Replacement for 'cat'
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
      };
    };
    # Shell history replacement
    atuin.enable = true;
    # Smarter 'cd' with 'z'
    zoxide.enable = true;
    dircolors.enable = true;

    # Prompt
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

    # fish
    # TODO decide on use
    # fish = {
    #   enable = true;

    #   interactiveShellInit = ''
    #     set fish_greeting # N/A
    #   '';

    #   plugins = [
    #     {
    #       # TODO: Remove this
    #       name = "fish-asdf";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "rstacruz";
    #         repo = "fish-asdf";
    #         rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
    #         sha256 = "39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c=";
    #       };
    #     }
    #     {
    #       name = "nix-env";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "lilyball";
    #         repo = "nix-env.fish";
    #         rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
    #         hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
    #       };
    #     }
    #   ];
    # };

    # ZSH
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

    # TODO Check if needed
    bash.enable = true;
  };
}
