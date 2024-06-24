{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    restish
    colima # NOTE requires docker (brew)
  ];

}
