{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fresh
  ];
}