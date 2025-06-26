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

  home.packages = with pkgs; [
    warp-terminal
  ];

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
        command_timeout = 800;
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

    # ZSH
    zsh.enable = true;
    # TODO move terraform configuration into the related template flake
    # TODO move docker configuration into the related template flake - if possible
    # Configure colima
    zsh.envExtra = ''
      export DOCKER_HOST=unix://$HOME/.colima/docker.sock
      export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
    '';

    zsh.profileExtra = ''
      [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source  ~/.nix-profile/etc/profile.d/nix.sh
      export XCURSOR_PATH=$XCURSOR_PATH:/usr/share/icons:~/.local/share/icons:~/.icons:~/.nix-profile/share/icons
    '';

    zsh.autosuggestion = {
      enable = true;
      strategy = [
        "match_prev_cmd"
        "completion"
      ];
    };

    zsh.enableCompletion = true;

    zsh.antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        # Completion
        # run towards the TOP of your .zsh_plugins.txt before any compdef calls
        "mattmc3/ez-compinit"
      ];
    };

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
    };

    # let the terminal track the current working directory
    zsh.enableVteIntegration = true;

    # TODO Check if needed
    bash.enable = true;
  };
}
