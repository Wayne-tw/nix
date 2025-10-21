{ pkgs, ... }:

{
  system.primaryUser = "wayne";
  environment.darwinConfig = "$HOME/nix";

# ----------------------------------------------------------------------
  # FIX: Declaratively create /etc/nix/nix.custom.conf for Determinate Nix
  # ----------------------------------------------------------------------
  environment.etc."nix/nix.custom.conf".text = ''
    # This configuration is necessary to allow 'wayne' to use binary caches
    # like the one required by devenv (Cachix) without being root.
    # We include root and for safety and system function.
    # Written by https://github.com/DeterminateSystems/nix-installer.
    # The contents below are based on options specified at installation time.
    trusted-users = root wayne
  '';
  # ----------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  nix = {
    enable = false;
  };
  homebrew = {
    enable = true;
    user = "wayne";

    brews = [
       "mas"
       "tfenv"
       "tf-summarize"
      # brew taps are managed in flake.nix
       "gossm"       
        "dojo"
    ];
    casks = [
    "google-chrome"
    "1password"
    "openlens"
    "zoom"
    "slack"
    "microsoft-teams"
    "obsidian"
    "raycast"
    ];
    masApps ={
    "RunCat" = 1429033973;
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };

#checks if it has the app and then launch service on open
  launchd.user.agents.runcat = {
    serviceConfig = {
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "[ -d /Applications/RunCat.app ] && /usr/bin/open -a /Applications/RunCat.app"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };


  programs = {
    gnupg.agent.enable = true;
  };

  fonts.packages = [
    pkgs.jetbrains-mono
    pkgs.nerd-fonts.jetbrains-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      mru-spaces = false;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/Notes.app"
        "/System/Applications/Freeform.app"
        "/Applications/zoom.us.app"
        "/Applications/Google Chrome.app"
        "/Users/wayne/Applications/Home Manager Apps/Warp.app"
        "/Applications/Obsidian.app"
      ];
    };
    finder = {
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
      NSAutomaticWindowAnimationsEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
    };
    loginwindow.GuestEnabled = false;
  };
}
