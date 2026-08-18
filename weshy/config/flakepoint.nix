{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    flakepoint
  ];
}