{ pkgs, ... }:

{
  system.primaryUser = "wayne";

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  environment.darwinConfig = "$HOME/nix";

  nix = {
    enable = false;
    package = pkgs.nix;
    settings = {
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "wayne"
      ];
    };
    extraOptions = ''
      auto-optimise-store = false
    '';
  };

  homebrew = {
    enable = true;

    taps = [
      "gjbae1212/gossm"
    ];

    brews = [
       "mas"
       "gossm"
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

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  fonts.packages = [
    pkgs.jetbrains-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "left";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
      mru-spaces = false;
      persistent-apps = [
        "/System/Applications/Calendar.app"
        "/Applications/Google Chrome.app"
        "/Applications/OpenLens.app"
      ];
    };
    finder = {
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
