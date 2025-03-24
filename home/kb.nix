{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  # NOTE obsidian 1.8.9 was broken on mac
  #       unpacking source archive /nix/store/83ll009y30zh6wrcn2i7351gg9y45wjr-Obsidian-1.8.9.dmg
  #       error: only HFS file systems are supported.
  # NOTE show how packages can be pinned to a specific nixpkgs version
  # unstable branch
  pkgs_obsidian_1_8_7 =
    import
      (pkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "31b5f3ba6361adde901c0c83b02f13212ccdc01f";
        sha256 = "iR9wRkor7/lKycBZ/w1rJWanV/Wd8bcIQALOl7jJmoM=";
      })
      {
        inherit (pkgs) system;
        config.allowUnfree = true;
      };
in
{
  home.packages = [
    pkgs.obsidian
    #pkgs_obsidian_1_8_7.obsidian
    # NOTE service execution is os dependent, hence a piece is in darwin.nix
    pkgs.ollama
  ];

  # TODO Install some models
  # Obsidian
  # - nomic-embed-text
  # - llama3.1
  # - gemma2
  # Emacs - Might need to be setup in emacs.nix
  # - zephyr
  #

  # FIXME not working, missing homebrew context
  #homebrew = {
  #  casks = [
  #    "obsidian"
  #    "msty"
  #  ];
  #};

}
