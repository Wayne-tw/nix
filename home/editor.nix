{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    code-cursor
  ];

  # TODO Version 0.158.2 marked as broken -> latest 0.164.2
  # -> https://github.com/NixOS/nixpkgs/pull/329653
  # https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/by-name/ze/zed-editor/package.nix
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zed-editor.enable
  programs.zed-editor = {
    enable = true;

    extensions = [
      "gemini"
      "golangci-lint"
      "gosum"
      "http"
      "make"
      "mermaid"
      "nix"
      "rego"
      "terraform"
    ];

    userSettings = {
      # https://zed.dev/docs/configuring-zed#direnv-integration
      load_direnv = "direct";
      autosave = "on_focus_change";
    };
  };
}
