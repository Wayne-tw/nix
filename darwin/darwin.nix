{ pkgs, ... }:

{
  system.primaryUser = "wayne";
  environment.darwinConfig = "$HOME/nix";

  environment.systemPackages = with pkgs; [
    home-manager
  ];

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
