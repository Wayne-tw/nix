{ config, pkgs, ... }:

{
  home = {
    shellAliases = {
      # bat --plain for unformatted cat
      catp = "bat -P";
      cat = "bat";
      # replace cd
      cd = "z";
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
    zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
        };
    };
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
      format = ''
        $directory$git_branch$git_status$nodejs$python$cmd_duration
        $character
        '';
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold yellow";
        };
      };
    };

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

      ls = "eza";
      ll = "eza -l";
      lt = "eza --tree";
      k  = "kubectl";
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
