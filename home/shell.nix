{ config, pkgs, ... }:

{
  home = {
    sessionPath = [
      "$HOME/bin"     # tfswitch
      "$HOME/go/bin"  # Go
    ];

    packages = with pkgs; [
      warp-terminal
    ];
  };

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;

      enableCompletion = true;
      enableVteIntegration = true;

      autosuggestion = {
        enable = true;
        strategy = [ "match_prev_cmd" "completion" ];
      };

      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          "mattmc3/ez-compinit"
        ];
      };

      envExtra = ''
        export DOCKER_HOST=unix://$HOME/.colima/docker.sock
        export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
      '';

      profileExtra = ''
        [ -r ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh
        export XCURSOR_PATH=$XCURSOR_PATH:/usr/share/icons:~/.local/share/icons:~/.icons:~/.nix-profile/share/icons
      '';

      shellAliases = {
        # General replacements
        cat = "bat";
        catp = "bat -P";
        cd = "z";

        # git
        gp = "git push";
        # ls
        ls = "eza";
        ll = "eza -l";
        lt = "eza --tree";

        # Terraform
        tf = "terraform";
        tfi = "terraform init -upgrade";
        tfp = "terraform plan";
        tfps = "terraform plan -no-color | grep -E '^[[:punct:]]+ resource|~ resource|\\+ resource |Plan' | sort";

        # Terramate
        tmg = "terramate generate";
        tmi = "terramate run -- terraform init -upgrade";
        tmp = "terramate run -- terraform plan";
        tma = "terramate run -- terraform apply";
        tmaa = "terramate run -- terraform apply -auto-approve";
        tmclone = "terramate experimental clone";

        # K8s
        k = "kubectl";
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [ "--group-directories-first" "--header" ];
    };

    bat = {
      enable = true;
      config.theme = "TwoDark";
    };

    atuin.enable = true;
    zoxide.enable = true;
    dircolors.enable = true;

    starship = {
      enable = true;
      settings = {
        format = "$directory$git_branch$git_status$cmd_duration $character";
        right_format = "$time";

        directory = {
          truncation_length = 3;
          style = "cyan";
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style) )";
        };

        cmd_duration = {
          min_time = 1000;
          format = "⏱ [$duration](bold yellow)";
        };

        time = {
          disabled = false;
          format = "[$time]($style)";
          time_format = "%H:%M";
          style = "bold dimmed white";
        };

        character = {
          success_symbol = "[❯](dimmed green)";
          error_symbol = "[❯](dimmed red)";
        };

        jobs.disabled = true;
      };
    };
  };
}
