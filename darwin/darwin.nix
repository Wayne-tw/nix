{
  # unused: config,
  pkgs,
  ...
}:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Use a custom configuration.nix location. Where ever your cloned files are.
  environment.darwinConfig = "$HOME/nix";

  # Auto upgrade nix package and the daemon service.
  nix = {
    # NOTE using determine to manage the nix installation which handles nix updates with a separate daemon.
    # SEE https://determinate.systems/posts/changelog-determinate-nix-342/
    enable = false;

    # TODO understand if this is still needed with using determine installer
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [
        "nix-command"
        "flakes"
      ];
      "trusted-users" = [
        # FIXME make dependent to the user name configuration - do not hard-code
        "wayne"
      ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true; # default shell on catalina
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.packages = [
    pkgs.atkinson-hyperlegible
    pkgs.jetbrains-mono
  ];


  # Storage optimisation
  # https://nixos.wiki/wiki/Storage_optimization
  # TODO should be os independent
  # NOTE disabled because of issue: https://github.com/NixOS/nix/issues/7273
  nix.extraOptions = ''
    auto-optimise-store = false
  '';

  homebrew = {
    # NOTE Enabling this option does not install Homebrew, see the Homebrew website for installation instructions.
    enable = true;
    global.autoUpdate = true;

    # SEE: https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.onActivation
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      # TODO find a way to install packages using go get - reduce brew usage
      "gossm"
    ];

    casks = [
      # TODO Migrate to nixpkgs _1password-gui when package is not broken anymore
      "1password"
      # TODO Migrate to nixpkgs
      "raycast"
      # TODO Migrate to nixpkgs
      "obsidian"
      "microsoft-teams"
    ];

    masApps = {
      "RunCat"               = 1429033973;
      "1Password for Safari" = 1569813296;
    };
  };

  # Enable sudo authentication with Touch ID.
  # https://daiderd.com/nix-darwin/manual/index.html#opt-security.pam.services.sudo_local.enable
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
      # Disable automatically rearrange spaces based on most recent use
      # https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.dock.mru-spaces
      mru-spaces = false;
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
      # avoid adding a period when pressing space bar two times
      # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled
      NSAutomaticPeriodSubstitutionEnabled = false;
    };
  };

}
