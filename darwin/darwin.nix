{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # TODO keep the default location to support use of `topgrade`
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/project/config/dotfiles-slim";
  #environment.darwinConfig = "$HOME/.config/nixpkgs/darwin";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # default shell on catalina
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.atkinson-hyperlegible
    pkgs.jetbrains-mono
  ];

  services = {
    yabai = {
      enable = true;
      config = {
        layout = "float";
        mouse_modifier = "ctrl";
        mouse_action1  = "resize";
        mouse_drop_action = "stack";
        window_gap     = "20";
        window_border  = "off";
        window_opacity = "off";
        window_shadow  = "off";
      };
      extraConfig = ''
        yabai -m rule --add app='Spotify' display=east

        yabai -m rule --add app='System Settings' manage=off
      '';
    };
  };

    # TODO Understand if there is potential to overwrite - since assignment is used
    # FIXME have homebrew bin in shell
  #programs.zsh.initExtra = ''
  #  export PATH="$\{PATH\}:/opt/homebrew/bin"
  # '';

  homebrew = {
    # NOTE Enabling this option does not install Homebrew, see the Homebrew website for installation instructions.
    enable = true;

    taps = [
      "gjbae1212/gossm"
    ];

    brews = [
      "gossm"
      # Make vterm work on emacs
      #      https://docs.doomemacs.org/v21.12/modules/term/vterm/
      "libvterm" # doomemacs vterm requirement
    ];

    casks = [
      # TODO Migrate to nixpkgs _1password-gui, _1password (cli)
      "1password"
      "beeper"
      "disk-inventory-x"
      "notion"
      "notion-calendar"
      # TODO Migrate to nixpkgs
      "karabiner-elements"
      "raycast"
      # TODO Migrate to nixpkgs
      "wezterm"
      "vivaldi"
      # aws specific tooling - currently unsupported package
      # TODO Migrate to engagement specific stuff
      # TODO how to install the plugins for logseq?
      "logseq"
      "mattermost"
      "microsoft-teams"
      # TODO separate private stuff
      "orcaslicer"
    ];

    masApps = {
      "Kindle" = 405399194;
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
      NSAutomaticWindowAnimationsEnabled = false;
    };
  };

  # Neo2 Keyboard Layout
  # needs additional configuration of karabiner-elements as part of home-manager /home/home.nix
  # https://github.com/Cu3PO42/gleaming-glacier/blob/5abb8c0a3fb72cafbc7ca113e5f135142d0b51c8/modules/darwin/neo2/default.nix#L9
  # https://github.com/Cu3PO42/gleaming-glacier/blob/5abb8c0a3fb72cafbc7ca113e5f135142d0b51c8/config/karabiner/LICENSE.md?plain=1
  system.activationScripts.extraActivation.text = ''
      echo "INFO :: Copying Neo layout into system wide folder"
      cp ${./neo.icns} "/Library/Keyboard Layouts/neo.icns"
      cp ${./neo.keylayout} "/Library/Keyboard Layouts/neo.keylayout"
   '';

}
