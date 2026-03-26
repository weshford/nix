{ config, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./dunst.nix
  ];

  my.home.hyprland.enable = lib.mkDefault false;
  my.home.waybar.enable = lib.mkDefault false;
  my.home.rofi.enable = lib.mkDefault false;
  my.home.dunst.enable = lib.mkDefault false;
}
