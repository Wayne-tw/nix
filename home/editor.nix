{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    code-cursor
    # VS Code for AI coding agent trials
    vscode-with-extensions
    vscode-extensions.continue.continue
    vscode-extensions.hashicorp.hcl
    vscode-extensions.hashicorp.terraform
    vscode-extensions.golang.go
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/by-name/ze/zed-editor/package.nix
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zed-editor.enable
  programs.zed-editor = {
    enable = true;

    extensions = [
      "basher"
      "dockerfile"
      "docker-compose"
      "gemini"
      "golangci-lint"
      "gosum"
      "http"
      "make"
      "mermaid"
      "nix"
      "rainbow-csv"
      "rego"
      "risor"
      "terraform"
      "markdown-oxide"
    ];

    userSettings = {
      # https://zed.dev/docs/configuring-zed#direnv-integration
      load_direnv = "direct";
      autosave = "on_focus_change";

      assistant = {
        default_model = {
          provider = "ollama";
          model = "qwen2.5-coder";
        };
      };
    };
  };
}
