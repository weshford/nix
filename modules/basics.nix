{ config, lib, pkgs, ... }:

let
  cfg = config.my.modules.basics;
in
{
  options.my.modules.basics.enable = lib.mkEnableOption "basic system configuration and utilities.. must needs etc";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wayland-utils
      wl-clipboard
      kitty
      xfce.thunar
      kdePackages.ark
      kdePackages.partitionmanager
      kdePackages.kate
      screen
      #  wget
    ];
  };
}