{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    # VS Code for AI coding agent trials
    vscode
    #vscode-with-extensions
    vscode-extensions.continue.continue
    vscode-extensions.hashicorp.hcl
    vscode-extensions.hashicorp.terraform
    vscode-extensions.golang.go
    jetbrains.idea-ultimate
  ];
  }